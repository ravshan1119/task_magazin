import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_magazin/src/domain/models/product_model_sql.dart';

class LocalDatabase {
  static final LocalDatabase getInstance = LocalDatabase._init();

  LocalDatabase._init();

  factory LocalDatabase() {
    return getInstance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDB("products.db");
      return _database!;
    }
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";
    const intType = "INTEGER DEFAULT 0";
    const doubleType = "REAL DEFAULT 0.0";

    await db.execute('''
    CREATE TABLE ${ProductsModelFields.productsTable} (
    ${ProductsModelFields.id} $idType,
    ${ProductsModelFields.productId} $intType,
    ${ProductsModelFields.title} $textType,
    ${ProductsModelFields.price} $doubleType,
    ${ProductsModelFields.description} $textType,
    ${ProductsModelFields.category} $textType,
    ${ProductsModelFields.image} $textType,
    ${ProductsModelFields.rate} $doubleType,
    ${ProductsModelFields.rateCount} $intType
    )
    ''');

    debugPrint("-------DB----------CREATED---------");
  }

  static Future<ProductModelSql> insertProduct(
      ProductModelSql productsModelSql) async {
    final db = await getInstance.database;
    final int id = await db.insert(
        ProductsModelFields.productsTable, productsModelSql.toJson());
    print("create product id: $id");
    return productsModelSql.copyWith(id: id);
  }

  static Future<List<ProductModelSql>> getAllProducts() async {
    List<ProductModelSql> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(ProductsModelFields.productsTable))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();

    return allProducts;
  }

  static updateProduct({required ProductModelSql productModelSql}) async {
    final db = await getInstance.database;
    db.update(
      ProductsModelFields.productsTable,
      productModelSql.toJson(),
      where: "${ProductsModelFields.id} = ?",
      whereArgs: [productModelSql.id],
    );
  }

  static Future<int> deleteProduct(int id) async {
    final db = await getInstance.database;
    int count = await db.delete(
      ProductsModelFields.productsTable,
      where: "${ProductsModelFields.id} = ?",
      whereArgs: [id],
    );
    return count;
  }

  static Future<List<ProductModelSql>> getProductsByLimit(int limit) async {
    List<ProductModelSql> allToDos = [];
    final db = await getInstance.database;
    allToDos = (await db.query(ProductsModelFields.productsTable,
            limit: limit, orderBy: "${ProductsModelFields.title} ASC"))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();

    return allToDos;
  }

  static Future<ProductModelSql?> getSingleProduct(int id) async {
    List<ProductModelSql> products = [];
    final db = await getInstance.database;
    products = (await db.query(
      ProductsModelFields.productsTable,
      where: "${ProductsModelFields.id} = ?",
      whereArgs: [id],
    ))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();

    if (products.isNotEmpty) {
      return products.first;
    }
    return null;
  }

  static Future<List<ProductModelSql>> getProductsByAlphabet(
      String order) async {
    List<ProductModelSql> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(ProductsModelFields.productsTable,
            orderBy: "${ProductsModelFields.title} $order"))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();
    return allProducts;
  }

  static Future<List<ProductModelSql>> getProductsByQuery(String query) async {
    List<ProductModelSql> allProducts = [];
    final db = await getInstance.database;
    allProducts = (await db.query(
      ProductsModelFields.productsTable,
      where: "${ProductsModelFields.title} LIKE ?",
      whereArgs: [query],
    ))
        .map((e) => ProductModelSql.fromJson(e))
        .toList();
    return allProducts;
  }
}
