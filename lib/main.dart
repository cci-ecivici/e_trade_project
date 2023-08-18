import '../screens/productList.dart';
import 'package:flutter/material.dart';
//import '../db/dbHelper.dart';
//import '../models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //test kodu
    /*List<Product>? products = <Product>[];
    DbHelper dbHelper = DbHelper();
    dbHelper.initializeDb().then((result) => dbHelper
        .getProducts()
        .then((value) => products = value.cast<Product>()));

    Product product = Product("Mouse", "Mouse Description", 30);
    dbHelper.insert(product);*/
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'E-Trade'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ProductList(),
    );
  }
}
