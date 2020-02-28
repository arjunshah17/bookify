import 'package:bookify/home/home.dart';
import 'package:bookify/screen/homeScreen.dart';
import 'package:bookify/screen/login.dart';
import 'package:bookify/screen/new_ad/AdScreen.dart';
import 'package:bookify/screen/product/product_detail.dart';
import 'package:bookify/screen/productListScreen.dart';
import 'package:bookify/screen/profile/ProfilePage.dart';
import 'package:bookify/screen/registration.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/user_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: UserProvider.initialize()),


  ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.orange[200],
                accentColor: Colors.purple[300]

        ),
       initialRoute: '/',
        routes:<String, WidgetBuilder>{
          '/': (BuildContext context) => ScreensController(),
          '/login':(BuildContext con)=>Login(),
          AdScreen.screenName:(BuildContext con)=>AdScreen(),

          SignUp.screenName:(BuildContext context)=>SignUp(),
          ProductListScreen.screenName:(BuildContext c)=>ProductListScreen(),
          ProductDetails.screenName:(BuildContext c)=>ProductDetails(),
          ProfilePage.screenName:(BuildContext c)=>ProfilePage()
      },
      )));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninitialized:
        return null;
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return HomePage();
      default: return Login();
    }
  }
}
