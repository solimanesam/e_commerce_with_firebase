import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:e_commerce_with_firebase/features/auth/domain/entity/user_entity.dart';

abstract class AuthBaseRepo {
  Future<Either<Failure, Unit>> logInUser(
      {required AuthInputModel authinputModel});
  Future<Either<Failure, Unit>> signUpUser(
      {required AuthInputModel authInputModel});

  Future addDataUser({required UserEntity userEntity});
}
