import '../db/dbHelper.dart';
import '../models/product.dart';
import '../screens/productDetail.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable !!!
class ProductUpdate extends StatefulWidget {
  Product product;
  ProductUpdate(this.product, {super.key});

  @override
  State<StatefulWidget> createState() => ProductUpdateState();
}

class ProductUpdateState extends State<ProductUpdate> {
  late TextEditingController txtName;
  late TextEditingController txtDescription;
  late TextEditingController txtPrice;
  DbHelper dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    txtName = TextEditingController(text: widget.product.name);
    txtDescription = TextEditingController(text: widget.product.description);
    txtPrice = TextEditingController(text: widget.product.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update ${widget.product.name}"),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            productNameField(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            ),
            productDescription(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            ),
            productPrice(),
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
            ),
            updateButton(),
          ],
        ),
      ),
    );
  }

  void update() async {
    await dbHelper.update(Product(txtName.text, txtDescription.text,
        double.tryParse(txtPrice.text) ?? 0.0));
    if (mounted) {
      var result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductDetail(widget.product)));
      if (result != 0 && mounted) {
        Navigator.pop(context, true);
      }
    }
  }

  Widget productNameField() {
    return TextFormField(
      controller: txtName,
      decoration: InputDecoration(
        labelText: widget.product.name,
        hintText: "Enter new name",
      ),
    );
  }

  Widget productDescription() {
    return TextFormField(
      controller: txtDescription,
      decoration: InputDecoration(
        labelText: widget.product.description,
        hintText: "Enter new description",
      ),
    );
  }

  Widget productPrice() {
    return TextFormField(
      controller: txtPrice,
      decoration: InputDecoration(
        labelText: "${widget.product.price}",
        hintText: "Enter new price",
      ),
    );
  }

  Widget updateButton() {
    return ElevatedButton(
      onPressed: () {
        update();
      },
      child: const Text("Update"),
    );
  }
}
