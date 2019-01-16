import 'package:flutter/material.dart';
import 'package:sql_lite_project/db/dbHepler.dart';
import 'package:sql_lite_project/models/product.dart';

class ProdutList extends StatefulWidget {
  _ProdutListState createState() => _ProdutListState();
}

class _ProdutListState extends State<ProdutList> {
  DbHelper dbHelper = new DbHelper();

  List<Product> products;

  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (products == null) {
      products = new List<Product>();
      getData();
    }
    return Scaffold(
      body: productListItems(),
    );
  }

  ListView productListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.amberAccent,
          elevation: 2,
          child: ListTile( //
            leading: CircleAvatar(
              backgroundColor: Colors.green,
              child: Text(this.products[position].name.substring(0,1)),
            ),
            title: Text(this.products[position].name),
            subtitle: Text(this.products[position].description),
            onTap: (){},
          ),
        );
      },
    );
  }

  void getData() {
    var db = dbHelper.initiliazeDb();

    db.then((result) {
      var productFuture = dbHelper.getProducts();
      productFuture.then((data) {
        List<Product> productsData = new List<Product>();

        count = data.length;
        for (var i = 0; i < count; i++) {
          productsData.add(Product.fromObject(data[i]));
        }

        setState(() {
          products = productsData;
          count = count;
        });
      });
    });
  }
}
