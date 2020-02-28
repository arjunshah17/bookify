import 'package:bookify/Provider/product_provider.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/utils/categoryList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CategoryPageView extends StatefulWidget {
  Function _function;

  CategoryPageView(this._function);

  @override
  _CategoryPageViewState createState() => _CategoryPageViewState();
}

class _CategoryPageViewState extends State<CategoryPageView> {
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    final product = Provider.of<ProductProvider>(context);

    return Container(
      child: GridView.builder(
        itemCount: Category.list.length,
        padding: EdgeInsets.all(20),
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 10,mainAxisSpacing: 10), itemBuilder: (BuildContext c,int index){
        return  Card(

          child:InkWell(
            splashColor:Theme.of(context).accentColor,
            onTap: (){
              product.product.category=Category.list[index].title;
              product.notifyListeners();
              widget._function.call();
            },
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    Category.list[index].icon,
                    height: _height / 12,
                    width: _width / 12,
                  ),


                  Text(Category.list[index].title)
                ],
              ),
            ),
          )
          ,

        );


      }
        ,
      ),

    );
  }
}