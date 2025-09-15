import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';

class OrderItem {
  final CoffeeEntity coffee;
  final int quantity;

  const OrderItem({
    required this.coffee,
    required this.quantity,
  });

  OrderItem copyWith({CoffeeEntity? coffee, int? quantity}) {
    return OrderItem(
      coffee: coffee ?? this.coffee,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "coffee": {
        "id": coffee.id,
        "name": coffee.name,
        "kind": coffee.kind,
        "price": coffee.price,
        "imageUrl": coffee.imageUrl,
      },
      "quantity": quantity,
    };
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      coffee: CoffeeEntity(
        id: map["id"],
        name: map["name"],
        kind: map["kind"],
        price: (map["price"] as num).toDouble(),
        imageUrl: map["imageUrl"],
      ),
      quantity: map["quantity"] ?? 1,
    );
  }
  factory OrderItem.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final map = doc.data()!;
    return OrderItem(
      coffee: CoffeeEntity(
        id: map["id"] ?? doc.id, // ✅ fallback على document id
        name: map["name"],
        kind: map["kind"],
        price: (map["price"] as num).toDouble(),
        imageUrl: map["imageUrl"],
      ),
      quantity: map["quantity"] ?? 1,
    );
  }
}

class OrderEntity {
  final String id;
  final String userId;
  final List<OrderItem> items;
  final String status;

  const OrderEntity({
    required this.id,
    required this.userId,
    required this.items,
    required this.status,
  });
}
