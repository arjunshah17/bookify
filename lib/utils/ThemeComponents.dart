import 'package:flutter/material.dart';



class ThemeComponents{
  static bottomButton( String title,  Color color,Function fun )
  {
    return Expanded(

      child: Align(

        alignment: FractionalOffset.bottomCenter,
        child: ButtonTheme(
          height: 50,
          minWidth: double.maxFinite,
          child: FlatButton(
            shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Text(title),color: color,onPressed:(){
              fun.call();
          },),
        ),
      ),
    );
  }
  static showSnackBar(BuildContext context,String text)
  {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(text),duration: Duration(milliseconds: 100),));
  }

}