

import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/utils/ThemeComponents.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:multi_image_picker/multi_image_picker.dart';
class ImagePageView extends StatefulWidget {
  Function _function;

  ImagePageView(this._function);


  @override
  _ImagePageViewState createState() => _ImagePageViewState();
}

class _ImagePageViewState extends State<ImagePageView> {
  ProductProvider product ;
  List<Asset> images = List<Asset>();
  String _error;


  Widget buildGridView() {

    return  GridView.builder(
        itemCount: images.length,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (BuildContext c,int index){
      Asset asset = images[index];
      return AssetThumb(
        asset: asset,
        width: 300,
        height: 300,
      );


    });
  }

  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();


    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;

      if (error == null) _error = 'No Error Dectected';
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
   return Padding(
        padding: EdgeInsets.all(10),
        child: Column(

          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            Center(child: Text('Error: $_error')),
            RaisedButton(
              child: Text("Pick images"),
              onPressed: loadAssets,
            ),
            Expanded(
              child: buildGridView(),
            )
            ,
            ThemeComponents.bottomButton("Next",Theme.of(context).primaryColor,(){
              if(images.length>0) {
                product.product.imageTemp=images;

                widget._function.call();
              }
              else
                {
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text("select images"),duration: Duration(milliseconds: 100),));
                }

            })
          ],
        ),
      );

  }


}
