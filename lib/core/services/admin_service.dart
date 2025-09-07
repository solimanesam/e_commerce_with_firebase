import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';

abstract class AdminService {
  // إدارة القهوة
  Future<void> addCoffee({required CoffeeModel coffee});
  Future<void> updateCoffee({required CoffeeModel coffee});
  Future<void> deleteCoffee({required String coffeeId});
  Future<List<CoffeeModel>> getAllCoffees();

  // إدارة الطلبات
  Future<List<OrderModel>> getAllOrders();
  Future<void> updateOrderStatus(
      {required String orderId, required String status});
}

class AdminServiceImpl implements AdminService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // القهوة
  @override
  Future<void> addCoffee({required CoffeeModel coffee}) async {
    var docRef = await firestore.collection("coffees").add(coffee.toMap());

    String generatedId = docRef.id;

    await docRef.update({"id": generatedId});
  }

  @override
  Future<void> updateCoffee({required CoffeeModel coffee}) async {
    await firestore.collection("coffees").doc(coffee.id).update(coffee.toMap());
  }

  @override
  Future<void> deleteCoffee({required String coffeeId}) async {
    await firestore.collection("coffees").doc(coffeeId).delete();
  }

  @override
  Future<List<CoffeeModel>> getAllCoffees() async {
    var snapshot = await firestore.collection("coffees").get();
    return snapshot.docs
        .map((doc) => CoffeeModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  // الطلبات
  @override
  Future<List<OrderModel>> getAllOrders() async {
    var snapshot = await firestore.collection("orders").get();
    return snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> updateOrderStatus(
      {required String orderId, required String status}) async {
    await firestore
        .collection("orders")
        .doc(orderId)
        .update({"status": status});
  }
}
