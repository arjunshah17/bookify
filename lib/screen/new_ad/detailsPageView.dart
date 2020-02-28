import 'dart:wasm';

import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/Provider/user_provider.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/utils/ThemeComponents.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:place_picker/uuid.dart';
import 'package:provider/provider.dart';
class DetailPageView extends StatefulWidget {
  Function _function;

  DetailPageView(this._function);

  @override
  _DetailPageViewState createState() => _DetailPageViewState();
}

class _DetailPageViewState extends State<DetailPageView> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Container(
        padding: EdgeInsets.all(20),
        child:FormBuilder(
      key: _fbKey,
      initialValue: {
        'date': DateTime.now(),

      },
      autovalidate: true,
child: Column(

  mainAxisSize: MainAxisSize.max,
  children: <Widget>[
    SizedBox(height: 30,),
    FormBuilderTextField(
      attribute: "name",

      decoration: InputDecoration(labelText: "title",hintText: "enter title", border: OutlineInputBorder(),),

      validators: [

        FormBuilderValidators.minLength(5),

      ],
    ),
    SizedBox(height: 30,),
            FormBuilderTextField(
            attribute: "description",
minLines: 2,
            decoration: InputDecoration(labelText: "description",hintText: "enter description", border: OutlineInputBorder(),),

    validators: [

    FormBuilderValidators.minLength(5),

    ],
    ),
    SizedBox(height: 30,),
    FormBuilderTextField(
      attribute: "price",

      decoration: InputDecoration(labelText: "price",hintText: "enter price", border: OutlineInputBorder(),),

      validators: [
         FormBuilderValidators.min(10),
        FormBuilderValidators.numeric(),

      ],
    ),



    ThemeComponents.bottomButton("Next",Theme.of(context).primaryColor,(){
      if (_fbKey.currentState.saveAndValidate()) {
        product.product.id=Uuid().generateV4();
        product.product.userId=user.user.uid;
        product.product.date=Timestamp.now();
        product.product.name=_fbKey.currentState.value['name'];
        product.product.description=_fbKey.currentState.value['description'];
        product.product.price=double.parse(_fbKey.currentState.value['price']);
        print(product);
        widget._function.call();
      }
    })

  ],

),
    ));




  }
}
