import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/exceptions.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/database_input_model.dart';
import 'package:e_commerce_with_firebase/core/services/auth_services.dart';
import 'package:e_commerce_with_firebase/core/services/database_service.dart';
import 'package:e_commerce_with_firebase/features/auth/data/model/auth_model.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/entity/user_entity.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/repos/auth_base_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends AuthBaseRepo {
  final AuthServices authServices;
  final DatabaseService databaseService;
  AuthRepo({required this.databaseService, required this.authServices});
  @override
  Future<Either<Failure, Unit>> signUpUser(
      {required AuthInputModel authInputModel}) async {
    User? user;
    try {
      user = await authServices.createUserWithEmailAndPassword(
          authInputModel: authInputModel);
      var userEntity = UserEntity(
          name: authInputModel.name!,
          email: authInputModel.email,
          uId: user.uid);
      addDataUser(userEntity: userEntity);
      return Right(unit);
    } on ServerException catch (e) {
      await deleteUser(user);
      print(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      print(
          'Exception in AuthRepoImpl.createUserWithEmailAndPassword: ${e.toString()}');
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logInUser(
      {required AuthInputModel authinputModel}) async {
    try {
      await authServices.signInWithEmailAndPassword(
          authInputModel: authinputModel);
      return const Right(unit);
    } on ServerException catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future addDataUser({required UserEntity userEntity}) async {
    await databaseService.addData(
        databaseInputModel: DatabaseInputModel(
            path: 'users',
            data: UserModel.fromEntity(userEntity).toMap(),
            docuementId: userEntity.uId));
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await authServices.deleteUser();
    }
  }
}
