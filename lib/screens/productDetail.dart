import '../db/dbHelper.dart';
import '../models/product.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProductDetail extends StatefulWidget {
  Product product;
  ProductDetail(this.product, {super.key});
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => ProductDetailState(product);
}

DbHelper dbHelper = DbHelper();

enum Choice { delete, update }

class ProductDetailState extends State {
  Product product;
  ProductDetailState(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Detail for ${product.name}"),
        actions: <Widget>[
          PopupMenuButton(
              onSelected: select,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
                    PopupMenuItem<Choice>(
                      value: Choice.delete,
                      child: Text("Delete ${product.name}"),
                    ),
                    PopupMenuItem<Choice>(
                      value: Choice.update,
                      child: Text("Update ${product.name}"),
                    )
                  ])
        ],
      ),
      body: Center(
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.shop),
                title: Text(product.name),
                subtitle: Text(product.description),
              ),
              Text("${product.name} price is => ${product.price}"),
              ButtonTheme(
                  child: ButtonBar(
                children: <Widget>[addToCardButton()],
              ))
            ],
          ),
        ),
      ),
    );
  }

  void select(Choice choice) async {
    switch (choice) {
      case Choice.delete:
        int result;
        Navigator.pop(context, true);
        result = await dbHelper.delete(product.id as int);
        if (result != 0) {
          AlertDialog alertDialog = AlertDialog(
            title: const Text("Success!"),
            content: Text("${product.name} ${choice.name}d! "),
          );
          if (mounted) {
            showDialog(context: context, builder: (_) => alertDialog);
          }
        }
        break;
      case Choice.update:
        AlertDialog alertDialog = AlertDialog(
          title: const Text("I will go to update page!"),
          content: Text("${product.name} ${choice.name} page "),
        );
        showDialog(context: context, builder: (_) => alertDialog);
        break;
      default:
    }
  }

  Widget addToCardButton() {
    return ElevatedButton(
        onPressed: () {
          AlertDialog alertDialog = AlertDialog(
            title: const Text("Success!"),
            content: Text("${product.name} added to card!"),
          );
          showDialog(context: context, builder: (_) => alertDialog);
        },
        child: const Text("Add to card"));
  }
}
