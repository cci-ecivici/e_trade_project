import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';

class DbHelper {
  String tblProduct = "Products";
  String colId = "Id";
  String colName = "Name";
  String colDescription = "Description";
  String colPrice = "Price";
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

//fonksiyon vasıtasıyla dbhelper çağrılır.
  factory DbHelper() {
    return _dbHelper;
  }

// db erişimi sağlanır ve aşağıdaki operasyonlar işlemlerin asenkron çalışmasını sağlar.
  static Database? _db;

  Future<Database> get db async => _db ??= await initializeDb();

  Future<Database> initializeDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}etrade.db";

    var dbEtrade = await openDatabase(path, version: 1, onCreate: _createDb);
    return dbEtrade;
  }

//CRUD operasyonları -- create, insert, update, delete
  void _createDb(Database db, int version) async {
    await db.execute(
        "Create Table $tblProduct($colId integer primary key, $colName text, $colDescription text, $colPrice int)");
  }

  Future<int> insert(Product product) async {
    Database db = await this.db; //db'ye erişim komutu.
    var result = await db.insert(tblProduct, product.toMap());
    return result;
  }

  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update(tblProduct, product.toMap(),
        where: "$colId =?", whereArgs: [product.id]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = db.rawDelete("Delete from $tblProduct where $colId=$id");
    return result;
  }

  Future<List> getProducts() async {
    Database db = await this.db;
    var result = db.rawQuery("Select * from $tblProduct");
    return result;
  }
}
