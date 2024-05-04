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

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'inicialPrice': inicialPrice,
      'image': image,
      'quantity': quantity,
    };
  }

  // static Future<List> getList() async {
  //   var db = await DBHelper.shared().db;
  //   var result = await db.query('tbProduct');
  //   return result;
  // }

  @override
  String toString() {
    return 'Product{id: $id, name: $name, price: $price, inicialPrice: $inicialPrice, image: $image, quantity: $quantity}';
  }
}