import 'package:bookify/Provider/user_provider.dart';
import 'package:bookify/screen/profile/ProfilePage.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserProvider>(context);

    return Column(
      children: <Widget>[


            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/drawer-header.jpg'),
                  )),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    _user.user.photoUrl),
              ),
              accountEmail: Text(_user.user.email,style: TextStyle(color: Colors.black),),
              accountName: Text(_user.user.displayName,style:TextStyle(color: Colors.black)),
            ),

        Expanded(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.home, color: Theme.of(context).accentColor),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.account_circle,
                    color: Theme.of(context).accentColor),
                title: Text('Profile'),
                trailing: Text('New',
                    style: TextStyle(color: Theme.of(context).primaryColor)),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ProfilePage.screenName);
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.category, color: Theme.of(context).accentColor),
                title: Text('Categorise'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/categorise');
                },
              ),
              ListTile(
                leading:
                    Icon(Icons.favorite, color: Theme.of(context).accentColor),
                title: Text('My Wishlist'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('4',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/wishlist');
                },
              ),
              ListTile(
                leading: Icon(Icons.shopping_cart,
                    color: Theme.of(context).accentColor),
                title: Text('My Cart'),
                trailing: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Text('2',
                      style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/cart');
                },
              ),
              ListTile(
                leading: Icon(Icons.lock, color: Theme.of(context).accentColor),
                title: Text('Login'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/auth');
                },
              ),
              Divider(),
              ListTile(
                leading:
                    Icon(Icons.settings, color: Theme.of(context).accentColor),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app,
                    color: Theme.of(context).accentColor),
                title: Text('Logout'),
                onTap: () async {
                  await _user.signOut();
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
