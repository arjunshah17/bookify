import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category{
  String title;
  String  icon;

  Category(this.title, this.icon);

  static final list=[
    Category("Books","assets/images/icons/book.png"
     ),
    Category("Instruments",'assets/images/icons/instruments.png'),
    Category("Software",'assets/images/icons/software.png'),
    Category("Sports",'assets/images/icons/sports-and-competition.png'),
    Category("Bags",'assets/images/icons/backpack.png'),
    Category("Project",'assets/images/icons/projects.png'),
    Category("Fashion",'assets/images/icons/fashion.png'),
    Category("Web Search",'assets/images/icons/web.png'),




  ];


}