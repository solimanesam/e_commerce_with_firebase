import 'package:e_commerce_with_firebase/features/admin_dashboard/domain/entities/coffee_entity.dart';

class CoffeeModel extends CoffeeEntity {
  const CoffeeModel({
    super.id, 
    required super.name,
    required super.price,
    required super.imageUrl,
  });

  factory CoffeeModel.fromMap(Map<String, dynamic> map, String id) {
    return CoffeeModel(
      id: id, 
      name: map["name"] ?? "",
      price: (map["price"] ?? 0).toDouble(),
      imageUrl: map["imageUrl"] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "imageUrl": imageUrl,
    };
  }
}
