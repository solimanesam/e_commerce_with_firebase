import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';

class OrderItem {
  final CoffeeEntity coffee;
  final int quantity;

  OrderItem({required this.coffee, required this.quantity});
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
