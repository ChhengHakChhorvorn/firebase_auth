import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product_model.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({
    Key? key,
    this.product,
  }) : super(key: key);
  final Product? product;

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPrice = TextEditingController();
  TextEditingController txtQty = TextEditingController();
  TextEditingController txtImageUrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      txtName.text = widget.product!.name;
      txtPrice.text = widget.product!.price;
      txtQty.text = widget.product!.qty;
      txtImageUrl.text = widget.product!.imageUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product != null ? 'Update' : 'Add Product'),
        actions: widget.product != null
            ? [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete),
                )
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Name'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtPrice,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Price'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtQty,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Qty'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: txtImageUrl,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Image Url'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                  color: Colors.purple,
                  child: Text(widget.product != null ? 'Update' : 'Add'),
                  onPressed: () async {
                    final db =
                        FirebaseFirestore.instance.collection('products');

                    final product = Product(
                        name: txtName.text,
                        price: txtPrice.text,
                        qty: txtQty.text,
                        imageUrl: txtImageUrl.text);

                    widget.product != null
                        ?
                        //Update
                        db.doc(widget.product!.id).update(product.toJson())
                        :
                        //Add
                        await db.add(product.toJson()).then(
                              (_) => Navigator.of(context).pop(),
                            );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
