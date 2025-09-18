import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/services/user_service.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';
import 'package:e_commerce_with_firebase/features/dashboard/domain/repos/orders_base_repo.dart';
import 'package:firebase_core/firebase_core.dart';

class OrdersRepo extends OrdersBaseRepo {
  final UserService userService;

  OrdersRepo({required this.userService});
  @override
  Future<Either<Failure, List<OrderModel>>> getUserOrders(
      {required String userId}) async {
    try {
      final orders = await userService.getUserOrders(userId: userId);
      return right(orders);
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> placeOrder(
      {required OrderModel orderModel}) async {
    try {
      await userService.placeOrder(order: orderModel);
      return right(unit);
    } on FirebaseException catch (e) {
      return left(ServerFailure(message: e.message ?? "Firebase error"));
    } on Exception catch (e) {
      return left(ServerFailure(message: e.toString()));
    }
  }
}
