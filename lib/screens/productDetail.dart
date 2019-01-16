import 'package:flutter/material.dart';
import 'package:sql_lite_project/db/dbHepler.dart';
import 'package:sql_lite_project/models/product.dart';

//for operations
enum Choice { Delete, Update }
DbHelper dbHelper = new DbHelper();

class ProductDetail extends StatefulWidget {
  Product product;
  //constructor
  ProductDetail(this.product);

  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  //constructor
  _ProductDetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("product detail : ${product.name}"),
        actions: <Widget>[
          PopupMenuButton<Choice>(
            onSelected: select,
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choice>>[
                  PopupMenuItem<Choice>(
                    value: Choice.Delete,
                    child: Text("Delete Product"),
                  ),
                  PopupMenuItem<Choice>(
                    value: Choice.Update,
                    child: Text("Update Product"),
                  ),
                ],
          )
        ],
      ),
      body: Center(
        child: Card(
            
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.shop_two),
                  title: Text(product.name),
                  subtitle: Text(product.description),
                ),
                Text("Price: ${product.price} USD"),
                ButtonTheme.bar(
                    child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Add to card"),
                      onPressed: () {
                        AlertDialog alertDialog = new AlertDialog(
                          title: Text("Info"),
                          content: Text("${product.name} added to cart!"),
                        );
                        showDialog(
                            context: context,
                            //_ we don't want to use any paramter
                            builder: (_) => alertDialog);
                      },
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }

  void select(Choice choice) async {
    int result;

    switch (choice) {
      case Choice.Delete:
        Navigator.pop(context, true);
        result = await dbHelper.delete(product.id);
        if (result != 0) {
          AlertDialog alertDialog = new AlertDialog(
            title: Text("Delete opetation was success"),
            content: Text("Product ${product.name} was deleted"),
          );
          showDialog(
              context: context,
              //_ we don't want to use any paramter
              builder: (_) => alertDialog);
        }
        break;
      default:
    }
  }
}
