import 'dart:developer';

import 'package:e_commerce_with_firebase/core/errors/exceptions.dart';
import 'package:e_commerce_with_firebase/core/models/auth_input_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<User> createUserWithEmailAndPassword(
      {required AuthInputModel authInputModel});
  Future<User> signInWithEmailAndPassword(
      {required AuthInputModel authInputModel});

  Future<void> deleteUser();
}

class FirebaseAuthServices extends AuthServices {
  @override
  Future<User> signInWithEmailAndPassword(
      {required AuthInputModel authInputModel}) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authInputModel.email,
        password: authInputModel.password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log('No user found for that email.');
        throw ServerException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        log('Wrong password provided for that user.');
        throw ServerException(
            message: 'Wrong password provided for that user.');
      } else if (e.code == 'invalid-credential') {
        throw ServerException(message: 'The email or password is incorrect');
      } else if (e.code == 'network-request-failed') {
        throw ServerException(message: 'Please check your internet connection');
      } else {
        throw ServerException(
            message: 'An unknown error occurred. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.signInWithEmailAndPassword: ${e.toString()}");

      throw ServerException(message: 'An error occurred. Please try again.');
    }
  }

  @override
  Future<User> createUserWithEmailAndPassword(
      {required AuthInputModel authInputModel}) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: authInputModel.email,
        password: authInputModel.password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()} and code is ${e.code}");
      if (e.code == 'weak-password') {
        throw ServerException(message: 'The password is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw ServerException(
            message: 'This email is already registered. Please log in.');
      } else if (e.code == 'network-request-failed') {
        throw ServerException(
            message: 'Please check your internet connection.');
      } else {
        throw ServerException(message: 'An error occurred. Please try again.');
      }
    } catch (e) {
      log("Exception in FirebaseAuthService.createUserWithEmailAndPassword: ${e.toString()}");

      throw ServerException(message: 'An error occurred. Please try again.');
    }
  }

  @override
  Future<void> deleteUser() async {
    await FirebaseAuth.instance.currentUser!.delete();
  }
}
