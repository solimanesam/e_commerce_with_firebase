class CoffeeEntity {
  final String? id;
  final String name;
  final String kind;
  final double price;
  final String imageUrl;

  const CoffeeEntity({
    this.id,
    required this.name,
    required this.kind,
    required this.price,
    required this.imageUrl,
  });
}
