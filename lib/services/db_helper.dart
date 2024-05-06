import 'package:postgres/postgres.dart';
import 'package:toten/models/product.dart';
import 'package:toten/models/cart_item.dart';
import 'package:toten/models/user.dart';

class DBHelper {
  Future<Connection> openConnection() async {
    final connection = await Connection.open(Endpoint(
      host: 'localhost',
      database: 'toten',
      username: 'douglas',
      password: 'batata',
    ));
    return connection;
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final connection = await openConnection();
    final result = await connection.execute(Sql.named('SELECT * FROM products WHERE category=@category'), parameters: {
      'category': category,
    });
    final products = result.map((row) => ProductModel.fromMap(row.toColumnMap())).toList();
    return products;
  }

  Future<List<ProductModel>> getProductsOnSale() async {
    final connection = await openConnection();
    final result = await connection.execute('SELECT * FROM products WHERE price < initial_price');
    final products = result.map((row) => ProductModel.fromMap(row.toColumnMap())).toList();
    return products;
  }

  // Future<List<UserModel>> getUsers() async {
  //   final connection = await openConnection();
  //   final result = await connection.execute('SELECT * FROM users');
  //   final users = result.map((row) => UserModel.fromMap(row.toColumnMap())).toList();
  //   return users;
  // }

  Future<UserModel> getUser(int id) async {
    final connection = await openConnection();
    final result = await connection.execute('SELECT * FROM users WHERE id = @id', parameters: {
      'id': id,
    });
    final user = UserModel.fromMap(result.first.toColumnMap());
    return user;
  }

  Future<void> updateUserBalance(UserModel user, double newBalance) async {
    final connection = await openConnection();
    await connection.execute('UPDATE users SET balance = @balance WHERE id = @id', parameters: {
      'balance': newBalance,
      'id': user.id,
    });
  }

  Future<void> insertOrder(List<CartItemModel> cartItems, UserModel user) async {
    final connection = await openConnection();
    final orderId = await connection.execute('INSERT INTO orders (user_id) VALUES (@userId) RETURNING id', parameters:{
      'userId': user.id,
    });
    final orderItems = cartItems.map((item) => connection.execute('INSERT INTO cart_items (order_id, product_id, quantity) VALUES (@orderId, @productId, @quantity)', parameters: {
      'orderId': orderId,
      'productId': item.product.id,
      'quantity': item.quantity,
    }));
    await Future.wait(orderItems);
  }

  // Future<List<Object>> fetchData() async {
  //   final products = await getProducts();
  //   // final users = await getUsers();
  //   return products;
  // }
}
