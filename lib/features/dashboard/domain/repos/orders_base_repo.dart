import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';

abstract class OrdersBaseRepo {
  Future<Either<Failure, Unit>> placeOrder({required OrderModel orderModel});
  Future<Either<Failure, List<OrderModel>>> getUserOrders(
      {required String userId});
}
