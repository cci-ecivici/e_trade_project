import '../db/dbHelper.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<StatefulWidget> createState() => ProductAddState();
}

class ProductAddState extends State {
  DbHelper dbHelper = DbHelper();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtDescription = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add a new product"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
          child: Column(children: <Widget>[
            productNameField(),
            productDescriptionField(),
            productPriceField(),
            saveButton(context),
          ]),
        ));
  }

  void save(BuildContext context) async {
    int result = await dbHelper.insert(Product(txtName.text,
        txtDescription.text, double.tryParse(txtPrice.text) ?? 0.0));
    if (result != 0 && mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget productNameField() {
    return TextField(
      controller: txtName,
      decoration:
          const InputDecoration(labelText: "Name", hintText: "Product Name"),
    );
  }

  Widget productDescriptionField() {
    return TextField(
      controller: txtDescription,
      decoration: const InputDecoration(
          labelText: "Description", hintText: "Product Description"),
    );
  }

  Widget productPriceField() {
    return TextField(
      controller: txtPrice,
      decoration:
          const InputDecoration(labelText: "Price", hintText: "Product Price"),
    );
  }

  Widget saveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        save(context); // Pass the context to the save function
      },
      child: const Text("Add"),
    );
  }
}
