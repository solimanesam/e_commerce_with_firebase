import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

abstract class CartBaseRepo {
  Future<Either<Failure, Unit>> addToCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  });
  Future<Either<Failure, Unit>> removeFromCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  });
  Future<Either<Failure, List<OrderItem>>> getCartItems(
      {required String userId});
  Future<Either<Failure, Unit>> clearCart({required String userId});
}
