import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/order_model.dart';

abstract class UserService {
  Future<void> placeOrder({required OrderModel order});
  Future<List<OrderModel>> getUserOrders({required String userId});
}

class UserServiceImpl implements UserService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // الطلبات
  @override
  Future<void> placeOrder({required OrderModel order}) async {
    var docRef = await firestore.collection("orders").add(order.toMap());
    String generatedId = docRef.id;

    // إضافة الـ id كحقل داخل الطلب
    await docRef.update({"id": generatedId});
  }

  @override
  Future<List<OrderModel>> getUserOrders({required String userId}) async {
    var snapshot = await firestore
        .collection("orders")
        .where("userId", isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
