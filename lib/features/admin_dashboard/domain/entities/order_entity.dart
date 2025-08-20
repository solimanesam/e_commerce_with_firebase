import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';

class OrderEntity {
  final String id;
  final String userId;
  final List<CoffeeEntity> items;
  final String status;

  const OrderEntity(
      {required this.id,
      required this.userId,
      required this.items,
      required this.status});
}
