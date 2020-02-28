import 'dart:collection';
import 'dart:wasm';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:place_picker/place_picker.dart';

class Product{
  static const ID = "id";
  static const CATEGORY = "category";
  static const NAME = "name";
  static const PRICE = "price";
  static const COVERIMAGE = "coverImage";
  static const DATE = "date";

  static const LOCATION = "location";
  static const USERID = "userId";
  static const FORMATEDADDRESS="formatedAddress";
  static const AREA="Area";

  static const DESCRIPTION = "description";

String _id,_name,_description,category,userId,coverImage;

double _price;
LocationResult locationResult;
String address;
String area;
List<String> _image =List<String>();
List<Asset> imageTemp =List<Asset>();
Timestamp date;

Product(this._id, this._name, this._description, this._price, this._image);
Product.empty();
List<String> get image => _image;

set image(List<String> value) {
  _image = value;
}

double get price => _price;

set price(double value) {
  _price = value;
}

get description => _description;

set description(value) {
  _description = value;
}

get name => _name;

set name(value) {
  _name = value;
}

String get id => _id;

set id(String value) {
  _id = value;
}

  HashMap<String,Object> toMap()
{
  Map data = HashMap<String,Object>();
  data[ID]=_id;
  data[USERID]=userId;
  data[NAME]=_name.toLowerCase();
  data[CATEGORY]=category;
  data[DESCRIPTION]=_description;
  data[COVERIMAGE]=coverImage;
  data[PRICE]=_price;
  data[DATE]=date;
  data[FORMATEDADDRESS]=address;


return data;

}

  Product.fromSnapshot(DocumentSnapshot data) {


    id=data[USERID];
    userId=data[USERID];
    _name=data[NAME];
    category=data[CATEGORY];
  address=data[FORMATEDADDRESS];
  date=data[DATE];
  area=data[AREA];
   _description= data[DESCRIPTION];
    coverImage=data[COVERIMAGE];
    _price=double.parse(data[PRICE].toString());


  }

}