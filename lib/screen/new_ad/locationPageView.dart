

import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/utils/ThemeComponents.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:bookify/utils/string.dart';
import 'package:bookify/widget/loading.dart';

import 'package:flutter/material.dart';
import 'package:place_picker/place_picker.dart';
import 'package:provider/provider.dart';
import 'dart:async';
class LocationPageView extends StatefulWidget {
  Function _function;

  LocationPageView(this._function);

  @override
  _LocationPageViewState createState() => _LocationPageViewState();
}

class _LocationPageViewState extends State<LocationPageView> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return product.state==Status.sending?Loading(): Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,

        children: <Widget>[
          Card(

            borderOnForeground: true,
            child:   ListTile(
              contentPadding: EdgeInsets.all(10),
              title:Text("location"),
            subtitle: Text("thaltej ahmedabad"),

            trailing: IconButton(icon: Icon(Icons.arrow_forward),
            onPressed:()async{

             LocationResult result= await showPlacePicker();
             if(result!=null)
               product.product.locationResult=result;
                 else {
                   product.product.locationResult=LocationResult();
               product.product.locationResult.name = "maple country 2";
               product.product.locationResult.formattedAddress =
               "thaltej shilaj road";
             }
product.notifyListeners();
              },),

            ),
          )
,Text(product.product.toMap().toString()),
         ThemeComponents.bottomButton("Post Now", Theme.of(context).primaryColor,(){

          if(product.product.locationResult!=null)
            {
              product.uploadData();
            }
          else
            {
ThemeComponents.showSnackBar(context, "select location");
            }


         })

        ],

      ),
    );
  }


    Future<LocationResult> showPlacePicker() async {
      LocationResult result = await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              PlacePicker(mapApi,



              )));

      // Handle the result in your way

      return result;
    }

}
