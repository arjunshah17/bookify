import 'dart:wasm';

class Product{
String _id,_name,_description,category;
double _price;
List<String> _image =List<String>();
List<String> imageTemp =List<String>();
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


}