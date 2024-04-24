import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static final DBHelper _singleton = DBHelper.internal();
  factory DBHelper() => _singleton;
  static Database? _db;
  DBHelper.internal();
  static DBHelper shared() => _singleton;

  static const String tbCart = 'cart';
  static const String tbCartItem = 'cart_item';
  static const String tbProduct = 'product';

  static const String cartId = 'id';

  static const String cartItemId = 'id';
  static const String cartItemCartId = 'cart_id';
  static const String cartItemProductId = 'product_id';

  static const String productId = 'id';
  static const String productName = 'name';
  static const String productPrice = 'price';
  static const String productInicialPrice = 'inicial_price';
  static const String productCategory = 'category';
  static const String productImage = 'image';
  static const String productQuantity = 'quantity';

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await initDB();
    return _db!;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'toten.db');
    var isDBExists = await databaseExists(path);
    if(kDebugMode){
      print(isDBExists);
      print(path);
    }

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);

    return db;
  }

  void _onCreate(Database db, int version) async {
    debugPrint('Creating database');

    await db.execute('''
      CREATE TABLE $tbCart (
        $cartId INTEGER PRIMARY KEY,
      )
    ''');

    await db.execute('''
      CREATE TABLE $tbCartItem (
        $cartItemId INTEGER PRIMARY KEY,
        $cartItemCartId INTEGER,
        $cartItemProductId INTEGER,
        FOREIGN KEY ($cartItemCartId) REFERENCES $tbCart($cartId),
        FOREIGN KEY ($cartItemProductId) REFERENCES $tbProduct($productId)
      )
    ''');

    await db.execute('''
      CREATE TABLE $tbProduct (
        $productId INTEGER PRIMARY KEY,
        $productName TEXT,
        $productPrice REAL,
        $productInicialPrice REAL,
        $productCategory TEXT,
        $productImage TEXT,
        $productQuantity INTEGER
      )
    ''');
  }

  static Future<int> insert(String table, Map<String, Object?> data) async {
    final db = await DBHelper.shared().database;
    return db.insert(table, data);
  }

  static Future<List<Map<String, Object?>>> query(String table) async {
    final db = await DBHelper.shared().database;
    return db.query(table);
  }

  static Future dbClearAll() async {
    if (_db == null) {
      return;
    }

    await _db!.delete(tbCart);
    await _db!.delete(tbCartItem);
    await _db!.delete(tbProduct);
  }

  static Future dbClearTable(String table) async {
    if (_db == null) {
      return;
    }

    await _db!.delete(table);
  }

  Future close() async {
    final db = await DBHelper.shared().database;
    db.close();
  }
}