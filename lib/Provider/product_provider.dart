import 'package:bookify/model/product.dart';
import 'package:flutter/cupertino.dart';
enum Status{intilize, editing,sending,sended}
class ProductProvider with ChangeNotifier{
Product product;
ProductProvider.init()
{
  product=Product.empty();

}


}