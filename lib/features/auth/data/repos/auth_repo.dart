import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/exceptions.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:e_commerce_with_firebase/core/models/database_input_model.dart';
import 'package:e_commerce_with_firebase/core/services/auth_services.dart';
import 'package:e_commerce_with_firebase/core/services/cache_service.dart';
import 'package:e_commerce_with_firebase/core/services/database_service.dart';
import 'package:e_commerce_with_firebase/features/auth/data/model/auth_model.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/entity/user_entity.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/repos/auth_base_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends AuthBaseRepo {
  final AuthServices authServices;
  final DatabaseService databaseService;
  final BaseCacheService cacheService;

  AuthRepo({
    required this.databaseService,
    required this.authServices,
    required this.cacheService,
  });

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

      // store uId and name in cache
      await cacheService.insertStringToCache(key: 'uId', value: user.uid);
      await cacheService.insertStringToCache(
          key: 'name', value: authInputModel.name!);

      await addDataUser(userEntity: userEntity);
      return Right(unit);
    } on ServerException catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteUser(user);
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> logInUser({
    required AuthInputModel authinputModel,
  }) async {
    try {
      final User user = await authServices.signInWithEmailAndPassword(
        authInputModel: authinputModel,
      );

      // ✅ save uId in cache
      await cacheService.insertStringToCache(key: 'uId', value: user.uid);

      // ✅ read user doc from Firestore
      final data = await databaseService.getData(
        databaseInputModel: DatabaseInputModel(
          path: 'users',
          docuementId: user.uid,
        ),
      );

      String name;

      if (data != null) {
        final userModel = UserModel.fromDocument(data);
        name = userModel.name;
      } else {
        // fallback لو document مش موجود
        name = "Guest";
      }

      // ✅ save name in cache
      await cacheService.insertStringToCache(key: 'name', value: name);

      return const Right(unit);
    } on ServerException catch (e) {
      print(e.message);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      print(e.toString());
      return Left(ServerFailure(message: e.toString()));
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
