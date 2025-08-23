import 'package:dartz/dartz.dart';
import 'package:e_commerce_with_firebase/core/errors/failures.dart';
import 'package:e_commerce_with_firebase/core/services/admin_service.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/repos/admin_base_repo.dart';
import 'package:firebase_core/firebase_core.dart';

class AdminRepo extends AdminBaseRepo {
  final AdminService adminService;
  AdminRepo({required this.adminService});
  @override
  Future<Either<Failure, Unit>> addCoffee({required CoffeeModel coffee}) async {
    try {
      await adminService.addCoffee(coffee: coffee);
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteCoffee({required String coffeeId}) async {
    try {
      await adminService.deleteCoffee(coffeeId: coffeeId);
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CoffeeEntity>>> getAllCoffees() async {
    try {
      final result = await adminService.getAllCoffees();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getAllOrders() async {
    try {
      return Right(await adminService.getAllOrders());
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateCoffee(
      {required CoffeeModel coffee}) async {
    try {
      await adminService.updateCoffee(coffee: coffee);
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateOrderStatus(
      {required String orderId, required String status}) async {
    try {
      await adminService.updateOrderStatus(orderId: orderId, status: status);
      return Right(unit);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(message: e.message ?? "Firebase error"));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
