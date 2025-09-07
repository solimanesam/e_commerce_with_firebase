import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

abstract class AdminBaseRepo {
  // إدارة القهوة
  Future<Either<Failure, Unit>> addCoffee({required CoffeeModel coffee});
  Future<Either<Failure, Unit>> updateCoffee({required CoffeeModel coffee});
  Future<Either<Failure, Unit>> deleteCoffee({required String coffeeId});
  Future<Either<Failure, List<CoffeeEntity>>> getAllCoffees();

  // إدارة الطلبات
  Future<Either<Failure, List<OrderEntity>>> getAllOrders();
  Future<Either<Failure, Unit>> updateOrderStatus(
      {required String orderId, required String status});
}
