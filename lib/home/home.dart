import 'package:bookify/model/product.dart';
import 'package:bookify/screen/product/product_detail.dart';
import 'package:bookify/screen/productListScreen.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:bookify/widget/loading.dart';
import 'package:bookify/widget/mainui_customcard.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


import 'drawer.dart';
import 'slider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isExpanded = false;
  double _height;
  double _width;
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: AppDrawer(),
      ),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: CustomScrollView(
            // Add the app bar and list of items as slivers in the next steps.
            slivers: <Widget>[
              SliverAppBar(
                // Provide a standard title.
                // title: Text('asdas'),
                // pinned: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
Navigator.pushNamed(context,ProductListScreen.screenName);

                    },
                  )
                ],
                // Allows the user to reveal the app bar if they begin scrolling
                // back up the list of items.
                // floating: true,
                // Display a placeholder widget to visualize the shrinking size.
                flexibleSpace: HomeSlider(),
                // Make the initial height of the SliverAppBar larger than normal.
                expandedHeight: 300,
              ),
              SliverList(
                // Use a delegate to build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                  // The builder function returns a ListTile with a title that
                  // displays the index of the current item.
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('Shop for',
                                style: TextStyle(
                                    fontSize: 16)),
                            GestureDetector(
                                onTap: _expand,
                                child: Text(
                                  isExpanded ? "Show less" : "Show all",
                                  style: TextStyle(
                                    color: Colors.orange[200],
                                  ),
                                )),
                            //IconButton(icon: isExpanded? Icon(Icons.arrow_drop_up, color: Colors.orange[200],) : Icon(Icons.arrow_drop_down, color: Colors.orange[200],), onPressed: _expand)
                          ],
                        ),
                      ),
                      expandList(),
                Divider(),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Trending",
                                style: TextStyle(
                                    fontSize: 16)),
                            GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(TRENDING_UI);
                                  print('Showing all');
                                },
                                child: Text(
                                  'Show all',
                                  style: TextStyle(
                                    color: Colors.orange[300],
                                  ),
                                ))
                          ],
                        ),
                      ),
                      trendingProducts(),Divider()
                    ],
                  ),
                  // Builds 1000 ListTiles
                  childCount: 1,
                ),
              )
            ]),
      ),
    );
  }

  Widget trendingProducts() {
    return Container(
      height: _height / 4.25,
      //width: MediaQuery.of(context).size.width,
      child:  StreamBuilder<QuerySnapshot>(
        stream:Firestore.instance.collection('products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting: return new Loading();
            default:
              return new ListView(
                shrinkWrap: true,

                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(5),
                children: snapshot.data.documents.map((DocumentSnapshot document) {
                  Product product=Product.fromSnapshot(document);
                  return  _buildRecommendationsEntries(context,product);
                }).toList(),
              );
          }
        },
      ),
    );
  }
  Widget _buildRecommendationsEntries(BuildContext context,Product listItem) {
    return GestureDetector(
onTap: (){
  Navigator.pushNamed(context, ProductDetails.screenName,arguments: listItem);
},
      child: CustomCard(

        title: '${listItem.name}',
        category: '${listItem.category}',
        price: "${NumberFormat.currency(symbol: "₹",decimalDigits: 0).format(listItem.price)}",
        dateAdded: "${DateFormat('yyyy-MM-dd').format( listItem.date.toDate())}",
        description: "${listItem.description}",
        image: "${listItem.coverImage}",
        location:listItem.area!=null?"${listItem.area}":"sarkhej,ahmedabad",
      ),
    );
  }
  Widget expandList() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
          itemCount:Category.list.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (BuildContext c,int i){
            return InkWell(
              onTap: (){

              },
              child: Column(children: <Widget>[
                Image.asset(
                  Category.list[i].icon,
                  height: _height / 12,
                  width: _width / 12,
                ),
                SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    Category.list[i].title,
                    style: TextStyle( fontSize: 13),
                  ),
                )
              ],),
            );
      },


        ),


    );
  }
  void _expand() {
    setState(() {
      isExpanded ? isExpanded = false : isExpanded = true;
    });
  }
}
