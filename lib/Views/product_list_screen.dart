import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';
import 'add_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  Stream<List<Product>> readProduct() =>
      FirebaseFirestore.instance.collection('products').snapshots().map(
            (snapshot) => snapshot.docs
                .map(
                  (doc) => Product.fromJson(
                    doc.data(),doc.id,
                  ),
                )
                .toList(),
          );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: StreamBuilder(
          stream: readProduct(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  children: snapshot.data!
                      .map(
                          (e) => ProductContainer(context: context, product: e))
                      .toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget ProductContainer(
    {required BuildContext context, required Product product}) {
  return GestureDetector(
    onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddProductScreen(
          product: product,
        ),
      ),
    ),
    child: Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 150,
            width: double.infinity,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Stock: " + product.qty),
              ],
            ),
          ),
          Text(
            "\$" + product.price,
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    ),
  );
}
