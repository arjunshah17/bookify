import 'package:bookify/Provider/user_provider.dart';
import 'package:bookify/home/home.dart';
import 'package:bookify/sale/salePage.dart';

import 'package:bookify/screen/profile.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'new_ad/AdScreen.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  Widget _bottomNavBar() {
    return BottomAppBar(
      notchMargin: 4,
      shape: AutomaticNotchedShape(RoundedRectangleBorder(),RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      child:  Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        decoration: BoxDecoration(

            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                setState(() {

                });
              },
            ),

            IconButton(
              icon: Icon(Icons.message),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);

          },
          children: <Widget>[
          Home(),
            Container(color: Colors.red,),

        Profile(user.user),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 3,
        onPressed: () {
          Navigator.pushNamed(context, AdScreen.screenName);
        },
        backgroundColor: Colors.orange[200],
        icon: Icon(Icons.camera_alt),
        label: Text("Post AD", textAlign: TextAlign.center,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavyBar(

        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home'),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('Chats'),
              icon: Icon(Icons.chat_bubble)
          ),


          BottomNavyBarItem(
              title: Text('Profile'),
              icon: Icon(Icons.account_circle)
          ),
        ],

      ),
    );
  }
}
