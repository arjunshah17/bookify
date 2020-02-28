import 'package:bookify/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'loading.dart';

class StreamSlider extends StatefulWidget {

 final String _product;
 StreamSlider(this._product);




  @override
  _StreamSliderState createState() => _StreamSliderState();
}

class _StreamSliderState extends State<StreamSlider> {
  final PageController ctrl = PageController(viewportFraction: 0.8);

  int currentPage = 0;

  Firestore _firestore=Firestore.instance;
  Stream slides;
  Stream _queryDb() {

    // Make a Query


    // Map the documents to the data payload
   slides = _firestore.collection('products').document(widget._product).collection("images").snapshots().map((list) => list.documents.map((doc) => doc.data));


    // Update the active tag

  }
  @override
  void initState() {
    _queryDb();
    ctrl.addListener(() {
      int next = ctrl.page.round();

      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Center(
            child:

          StreamBuilder<QuerySnapshot>(
          stream:Firestore.instance.collection('products').document(widget._product).collection("images").snapshots(),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasError)
    return new Text('Error: ${snapshot.error}');
    switch (snapshot.connectionState) {
    case ConnectionState.waiting: return new Loading();
    default:return ListView(
        children: snapshot.data.documents.map((DocumentSnapshot document) {

          return  CachedNetworkImage(
            imageUrl: document.data['url'],
          );
        }).toList()
    );
    }
    },
    ),

          )

        ],
      ),
    );
  }
}
