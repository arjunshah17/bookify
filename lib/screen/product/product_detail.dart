import 'package:bookify/db/product.dart';
import 'package:bookify/home/slider.dart';
import 'package:bookify/model/product.dart';
import 'package:bookify/utils/ThemeComponents.dart';
import 'package:bookify/utils/string.dart';
import 'package:bookify/widget/streamSlider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductDetails extends StatefulWidget {

  static final screenName="/productDetail";



  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {


   ProductService _productService;


  @override
  Widget build(BuildContext context) {
    Product   product = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail'),
      ),
      body: SafeArea(
          top: false,
          left: false,
          right: false,
          child: SingleChildScrollView(
            child: Column(

              children: <Widget>[

                SizedBox(
                width: double.infinity,
                  height: 260,
                  child:HomeSlider()

                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(

                    children: <Widget>[
                      Container(
                        alignment: Alignment(-1.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Text(
                            product.name,
                            style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "${NumberFormat.currency(symbol: "₹",decimalDigits: 0).format(product.price)}",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            Row(
                              children: <Widget>[
                                SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (v) {
                                    },
                                    starCount: 5,
//                                rating: product['rating'],
                                    size: 20.0,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: -0.8
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                      '(0.00)',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                      )
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment(-1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                    'Description',
                                  style: TextStyle(color: Colors.black, fontSize: 20,  fontWeight: FontWeight.w600),
                                ),
                              )
                          ),
                          Container(
                              alignment: Alignment(-1.0, -1.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Text(
                                  product.description,
                                  style: TextStyle(color: Colors.black, fontSize: 16),
                                ),
                              )
                          ),

                          FlatButton(
                            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                            child: Text("show information"),color: Theme.of(context).accentColor,onPressed:(){
                          },)

                        ],

                      ),


                    ],

                  ),
                ),

              ],
            ),
          ),

      ),
    );
  }
}
