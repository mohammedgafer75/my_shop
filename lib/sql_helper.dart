import 'dart:ffi';
import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import './model/product.dart';
import './model/sells.dart';

class Sql_Helper {
  static Sql_Helper dbHelper;
  static Database _database;
  Sql_Helper._createInstance();
  factory Sql_Helper() {
    if (dbHelper == null) {
      dbHelper = Sql_Helper._createInstance();
    }
    return dbHelper;
  }
  String tableName = "Products";
  String _id = "id";
  String _name = "name";
  String _salary = "salary";
  String _proft = "proft";
  String _date = "date";
  String _fsalary = "fsalary";
  String _kg = "kg";
  String _count = "count";
  String tableName1 = "Week";
  String _id1 = "id";
  String _items1 = "item";
  String _itemProft1 = "itemProft";
  String _weekProft = "weekProft";
  String tableName2 = "Month";
  String _id2 = "id";
  String _itemProft2 = "itemProft";
  String _items2 = "Items";
  String _monthProft = "monthProft";
  String tableName3 = "Sells";
  String _id3 = "id";
  String _name3 = "name";
  String _date3 = "date";
  String _proft3 = "Proft";
  String _count3 = "count";
  String _kg3 = "kg";

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializedDatabase();
    }
    return _database;
  }

  Future<Database> initializedDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + "products.db";

    var productDb =
        await openDatabase(path, version: 1, onCreate: createDatabase);
    return productDb;
  }

  void createDatabase(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableName($_id INTEGER PRIMARY KEY AUTOINCREMENT,$_name TEXT,$_salary INTEGER, $_proft INTEGER,$_date TEXT,$_fsalary INTEGER, $_kg INTEGER, $_count INTEGER)");
    await db.execute(
        "CREATE TABLE $tableName1($_id1 INTEGER PRIMARY KEY AUTOINCREMENT,$_items1 TEXT,$_itemProft1 INTEGER,$_weekProft INTEGER)");
    await db.execute(
        "CREATE TABLE $tableName2($_id2 INTEGER PRIMARY KEY AUTOINCREMENT,$_items2 TEXT,$_itemProft2 INTEGER,$_monthProft INTEGER)");
    await db.execute(
        "CREATE TABLE $tableName3($_id3 INTEGER PRIMARY KEY AUTOINCREMENT,$_name3 TEXT,$_proft INTEGER,$_count3 INTEGER,$_date3 TEXT,$_kg3 INTEGER)");
  }

  Future<List<Map<String, dynamic>>> getProduct() async {
    Database db = await this.database;
    var res = await db.query(tableName, orderBy: "$_id ASC");
    return res.toList();
  }

  Future<List<Map<String, dynamic>>> getbyId(int id) async {
    Database db = await this.database;
    var res = await db.query(tableName, where: "$_id", whereArgs: [id]);
    return res;
  }

  Future<int> insertProduct(Product product) async {
    Database db = await this.database;
    var res = await db.insert(tableName, product.toMap());
    return res;
  }

  Future<int> updateProduct(Product pro) async {
    Database db = await this.database;
    var res = await db
        .update(tableName, pro.toMap(), where: "$_id = ?", whereArgs: [pro.id]);
    return res;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await this.database;
    var res = await db.delete(tableName, where: "$_id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> all =
        await db.rawQuery("SELECT COUNT (*) FROM $tableName");
    int res = Sqflite.firstIntValue(all);
    return res;
  }

  Future<int> deleteSell(String name) async {
    Database db = await this.database;
    var res =
        await db.delete(tableName3, where: "$_name3 = ?", whereArgs: [name]);
    return res;
  }

  Future<int> sell(Sells sells) async {
    Database db = await this.database;
    var res = await db.insert(tableName3, sells.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> getSells() async {
    Database db = await this.database;
    var res = await db.query(tableName3, orderBy: "$_id ASC");
    return res.toList();
  }

  Future<List<Map<String, dynamic>>> getSellDay(String day) async {
    Database db = await this.database;
    var res = await db.query(tableName3,
        where: "$_date3 = ?", whereArgs: [day], orderBy: "$_id ASC");
    return res.toList();
  }

  Future<int> updateSells(Sells sells) async {
    Database db = await this.database;
    var res = await db.update(tableName3, sells.toMap(),
        where: "$_name = ?", whereArgs: [sells.itemName]);
    return res;
  }

  Future<int> delete() async {
    Database db = await this.database;
    var res = await db.delete(tableName);
    var res2 = await db.delete(tableName1);
    var res3 = await db.delete(tableName2);
    var res4 = await db.delete(tableName3);
    if (res > 0 && res2 > 0 && res3 > 0 && res4 > 0) {
      return res;
    } else {
      return 0;
    }
  }
}
