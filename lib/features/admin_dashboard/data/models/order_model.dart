import 'package:e_commerce_with_firebase/features/admin_dashboard/data/models/coffee_model.dart';
import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.userId,
    required super.items,
    required super.status,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map, String id) {
    return OrderModel(
      id: id,
      userId: map["userId"] ?? "",
      status: map["status"] ?? "pending",
      items: (map["items"] as List<dynamic>? ?? [])
          .map((e) => OrderItem(
                coffee: CoffeeModel.fromMap(
                    Map<String, dynamic>.from(e["coffee"]),
                    e["coffee"]["id"] ?? ""),
                quantity: e["quantity"] ?? 1,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "status": status,
      "items": items
          .map((e) => {
                "coffee": (e.coffee as CoffeeModel).toMap(),
                "quantity": e.quantity,
              })
          .toList(),
    };
  }
}
