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
    final result = await connection.execute(Sql.named('SELECT * FROM products WHERE category=@category ORDER BY (initial_price - price) DESC'), parameters: {
      'category': category,
    });
    final products = result.map((row) => ProductModel.fromMap(row.toColumnMap())).toList();
    return products;
  }

  Future<List<ProductModel>> getProductsOnSale() async {
    final connection = await openConnection();
    final result = await connection.execute('SELECT * FROM products WHERE price < initial_price ORDER BY (initial_price - price) DESC');
    final products = result.map((row) => ProductModel.fromMap(row.toColumnMap())).toList();
    return products;
  }

  Future<UserModel> getUser(int id) async {
    final connection = await openConnection();
    final result = await connection.execute(Sql.named('SELECT * FROM users WHERE id = @id'), parameters: {
      'id': id,
    });
    final user = UserModel.fromMap(result.first.toColumnMap());
    return user;
  }

  Future<void> updateUserBalance(UserModel user, double newBalance) async {
    final connection = await openConnection();
    await connection.execute(Sql.named('UPDATE users SET balance = @balance WHERE id = @id'), parameters: {
      'balance': newBalance,
      'id': user.id,
    });
  }

  Future<void> updateProductsQuantity(List<CartItemModel> cartItems) async {
    final connection = await openConnection();
    final updateProducts = cartItems.map((item) => connection.execute(Sql.named('UPDATE products SET quantity = @quantity WHERE id = @id'), parameters: {
      'quantity': item.product.quantity - item.quantity.value,
      'id': item.product.id,
    }));
    await Future.wait(updateProducts);
  }

  Future<void> insertOrder(List<CartItemModel> cartItems, UserModel user) async {
    final connection = await openConnection();
    final resultId = await connection.execute(Sql.named('INSERT INTO orders (user_id) VALUES (@userId) RETURNING id'), parameters:{
      'userId': user.id,
    });
    int orderId = resultId[0][0] as int;
    final orderItems = cartItems.map((item) => connection.execute(Sql.named('INSERT INTO cart_items (order_id, product_id, quantity) VALUES (@orderId, @productId, @quantity)'), parameters: {
      'orderId': orderId,
      'productId': item.product.id,
      'quantity': item.quantity.value,
    }));
    double total = cartItems.fold(0, (total, item) => total + item.product.price * item.quantity.value);
    await updateUserBalance(user, user.balance - total);
    await updateProductsQuantity(cartItems);
    await Future.wait(orderItems);
  }

  // Future<List<Object>> fetchData() async {
  //   final products = await getProducts();
  //   // final users = await getUsers();
  //   return products;
  // }
}
