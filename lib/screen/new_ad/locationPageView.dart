

import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/utils/ThemeComponents.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:bookify/utils/string.dart';
import 'package:bookify/widget/loading.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
  TextEditingController addressController;
  TextEditingController areaController;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
    final product = Provider.of<ProductProvider>(context);
    return product.state==Status.sending?Loading(): Container(
      margin: EdgeInsets.only(top: 2),
      padding: EdgeInsets.all(10),
      child: Form(
        key:_fbKey ,
        child: Column(
          mainAxisSize: MainAxisSize.max,

          children: <Widget>[
            Card(

              borderOnForeground: true,
              child:   ListTile(
                contentPadding: EdgeInsets.all(10),
                title:Text("location"),
              subtitle: Text("sharkej, ahmedabad"),

              trailing: IconButton(icon: Icon(Icons.arrow_forward),
              onPressed:()async{

               LocationResult result= await showPlacePicker();

                 product.product.locationResult=result;


                     product.product.locationResult=LocationResult();

                     product.product.address="Lj institute of Engineering and Technology near kataria motors";
                     product.product.area="sarkhej,ahmedabad";
                     setState(() {
                       addressController.text=product.product.address;
                       areaController.text=product.product.area;
                     });

product.notifyListeners();
                },),

              ),
            ),
            SizedBox(height: 10,),
TextFormField(
  controller: addressController,
  decoration: InputDecoration(labelText: "address",hintText: "enter address", border: OutlineInputBorder(),),
validator:FormBuilderValidators.required() ,

),
            SizedBox(height: 10,),
            TextFormField(
              controller: areaController,

              decoration: InputDecoration(labelText: "area",hintText: "enter area", border: OutlineInputBorder(),),
              validator:FormBuilderValidators.required() ,

            )
,
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
