import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/model/product.dart';
import 'package:bookify/screen/new_ad/categoryPageView.dart';
import 'package:bookify/screen/new_ad/detailsPageView.dart';
import 'package:bookify/screen/new_ad/imagePageView.dart';
import 'package:bookify/utils/enum.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AdScreen extends StatefulWidget {
  final Product product=Product.empty();
  static const screenName="adScreen";
  @override
  _AdScreenState createState() => _AdScreenState();
}

class _AdScreenState extends State<AdScreen> {

  PageController _controller = PageController(
    initialPage: 0,
  );
  String _appBarTitle="select category";

  @override
  Widget build(BuildContext context) {


    return MultiProvider(

      providers:[  ChangeNotifierProvider.value(value: ProductProvider.init())],

      child: Scaffold(

        appBar: AppBar(title: Text(_appBarTitle),

        ),
        body: PageView(
          controller: _controller,
         physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
          CategoryPageView((){


_controller.animateToPage(AdScreenPos.details.index,duration: Duration(milliseconds: 200),curve: Curves.ease);





          }),
            DetailPageView((){



_controller.animateToPage(AdScreenPos.images.index,duration: Duration(milliseconds: 200),curve: Curves.ease);

            }),

        ImagePageView(),
          ],
        ),

      ),
    );


  }
}
