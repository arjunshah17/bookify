import 'package:bookify/model/product.dart';
import 'package:bookify/screen/product/product_detail.dart';
import 'package:bookify/utils/string.dart';
import 'package:bookify/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ProductListScreen extends StatefulWidget {
  static final screenName="/productListScreen";

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String searchKey="";
  TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon( Icons.filter_list), onPressed: (){

          })
        ],
        title: TextField(controller: searchController ,onChanged: (text){
          setState(() {
            searchKey=text;
          });
        },),),
      body: Container(
          margin: EdgeInsets.only(top: 20),
          padding: EdgeInsets.all(10),
          child:   StreamBuilder<QuerySnapshot>(
            stream:searchKey==""? Firestore.instance.collection('products').snapshots():Firestore.instance.collection('products').orderBy('name').where("name",isGreaterThanOrEqualTo: searchKey).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError)
                return new Text('Error: ${snapshot.error}');
              switch (snapshot.connectionState) {
                case ConnectionState.waiting: return new Loading();
                default:
                  return new GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    padding: EdgeInsets.all(10),
                    children: snapshot.data.documents.map((DocumentSnapshot document) {
                      Product product=Product.fromSnapshot(document);
                      return  Container(
                        child: Card(
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: (){
                              Navigator.pushNamed(context,ProductDetails.screenName,arguments: product);
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: (MediaQuery.of(context).size.width / 2 - 5),
                                  width: double.infinity,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: product.coverImage,
                                    placeholder: (context, url) => Center(
                                        child: CircularProgressIndicator()
                                    ),
                                    errorWidget: (context, url, error) => new Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: ListTile(
                                    title: Text(
                                      product.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 2.0, bottom: 1),
                                              child: Text("${NumberFormat.currency(symbol: "₹",decimalDigits: 0).format(product.price)}", style: TextStyle(
                                                color: Theme.of(context).accentColor,
                                                fontWeight: FontWeight.w700,
                                              )),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 15),
                                        Row(children: <Widget>[
                                          Icon(Icons.location_on,color: Theme.of(context).accentColor,),
                                          Text(product.area==null?"sarkhej":product.area)


                                        ],)
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
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

