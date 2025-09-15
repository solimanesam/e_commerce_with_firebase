import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

abstract class CartService {
  // 🛒 إضافة / تحديث
  Future<void> addToCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  });

  // 🛒 تقليل الكمية أو حذف
  Future<void> removeFromCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  });

  // 🛒 الحصول على عناصر السلة
  Future<List<OrderItem>> getCartItems({required String userId});

  // 🛒 تفريغ السلة
  Future<void> clearCart({required String userId});
}

class CartServiceImpl implements CartService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> _cartRef(String userId) {
    return firestore.collection("users").doc(userId).collection("cart");
  }

  @override
  Future<void> addToCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  }) async {
    final docRef = _cartRef(userId).doc(coffee.id);
    final snapshot = await docRef.get();

    if (snapshot.exists) {
      final currentQuantity = snapshot.data()?["quantity"] ?? 1;
      await docRef.update({
        "quantity": currentQuantity + quantity,
      });
    } else {
      await docRef.set({
        "id": docRef.id,
        "name": coffee.name,
        "kind": coffee.kind,
        "price": coffee.price,
        "imageUrl": coffee.imageUrl,
        "quantity": quantity,
      });
    }
  }

  @override
  Future<void> removeFromCart({
    required String userId,
    required CoffeeModel coffee,
    int quantity = 1,
  }) async {
    final docRef = _cartRef(userId).doc(coffee.id);
    print("Trying to remove doc with id: ${coffee.id}");

    final snapshot = await docRef.get();
    print("Document exists? ${snapshot.exists}");

    if (!snapshot.exists) {
      print("No document found for this id");
      return;
    }

    final currentQuantity = snapshot.data()?["quantity"] ?? 1;
    if (currentQuantity > quantity) {
      await docRef.update({
        "quantity": currentQuantity - quantity,
      });
      print("Decreased quantity by $quantity");
    } else {
      await docRef.delete();
      print("Item removed completely");
    }
  }

  @override
  Future<List<OrderItem>> getCartItems({required String userId}) async {
    final querySnapshot = await _cartRef(userId).get();

    return querySnapshot.docs.map((doc) {
      return OrderItem.fromDoc(doc);
    }).toList();
  }

  @override
  Future<void> clearCart({required String userId}) async {
    final items = await _cartRef(userId).get();
    for (var doc in items.docs) {
      await doc.reference.delete();
    }
  }
}
