class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.initialPrice,
    required this.category,
    required this.image,
    required this.quantity,
  });

  final int id;
  final String name;
  final double price;
  final double initialPrice;
  final String category;
  final String image;
  final int quantity;

  static ProductModel fromMap(Map<String, Object?> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: double.parse(map['price'] as String),
      initialPrice: double.parse(map['initial_price'] as String),
      category: map['category'] as String,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, initialPrice: $initialPrice, image: $image, quantity: $quantity}';
  }
}