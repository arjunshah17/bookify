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
  @override
  Widget build(BuildContext context) {
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
                     Icon(Category.list[index].icon,size: 30,),

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
