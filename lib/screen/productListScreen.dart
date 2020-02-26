import 'package:bookify/model/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  static final screenName="/productListScreen";
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child:   StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                Product product=Product.fromSnapshot(document);
                return new Card(

                  child: ListTile(
                    leading:

                   product.coverImage!=null? CachedNetworkImage(
                      fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      imageUrl: product.coverImage,
                      placeholder: (context, url) =>
                          Center(
                              child:
                              CircularProgressIndicator()),
                      errorWidget:
                          (context, url, error) =>
                      new Icon(Icons.error),
                    ):Text("not found"),
                    title: Text(product.name),
                    subtitle: Text(product.description),

                  ),

                );
              }).toList(),
            );
        }
      },
    )
      ),
      
    );
  }
}
