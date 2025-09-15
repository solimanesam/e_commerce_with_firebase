import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/services/cart_service.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:e_commerce_with_firebase/features/dashboard/domain/repos/cart_base_repo.dart';

class CartRepo extends CartBaseRepo {
  final CartService cartService;

  CartRepo({required this.cartService});
  @override
  Future<Either<Failure, Unit>> addToCart(
      {required String userId,
      required CoffeeModel coffee,
      int quantity = 1}) async {
    try {
      await cartService.addToCart(
          userId: userId, coffee: coffee, quantity: quantity);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearCart({required String userId}) async {
    try {
      await cartService.clearCart(userId: userId);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderItem>>> getCartItems(
      {required String userId}) async {
    try {
      return right(await cartService.getCartItems(userId: userId));
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> removeFromCart(
      {required String userId,
      required CoffeeModel coffee,
      int quantity = 1}) async {
    try {
      await cartService.removeFromCart(
          userId: userId, coffee: coffee, quantity: quantity);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
