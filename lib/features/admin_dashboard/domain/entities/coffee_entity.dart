class CoffeeEntity {
  final String? id;
  final String name;
  final double price;
  final String imageUrl;

  const CoffeeEntity({
    this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}
