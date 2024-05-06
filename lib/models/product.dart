class ProductModel {
  const ProductModel({
    required this.id,
    required this.name,
    required this.price,
    this.inicialPrice = 0.0,
    required this.category,
    required this.image,
    required this.quantity,
  });

  final int id;
  final String name;
  final double price;
  final double inicialPrice;
  final String category;
  final String image;
  final int quantity;

  static ProductModel fromMap(Map<String, Object?> map) {
    return ProductModel(
      id: map['id'] as int,
      name: map['name'] as String,
      price: double.parse(map['price'] as String),
      inicialPrice: double.parse(map['price'] as String),
      category: map['category'] as String,
      image: map['image'] as String,
      quantity: map['quantity'] as int,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, inicialPrice: $inicialPrice, image: $image, quantity: $quantity}';
  }
}