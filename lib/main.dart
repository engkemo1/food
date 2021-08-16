import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foood/Providers/APP.dart';
import 'package:foood/Providers/user.dart';
import 'package:foood/screens/Home_Screen.dart';
import 'package:foood/screens/Login.dart';
import 'package:provider/provider.dart';

import 'Providers/Category.dart';
import 'Providers/Products.dart';
import 'Providers/res.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: AppProvider()),
          ChangeNotifierProvider.value(value: UserProvider.initialize()),
          ChangeNotifierProvider.value(value: UserProvider.initialize()),
          ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
          ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
          ChangeNotifierProvider.value(value: ProductProvider.initialize()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Food App',
            theme: ThemeData(
              primarySwatch: Colors.red,
            ),
            home: ScreensController()));
  }
  }

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Login();
      case Status.Unauthenticated:

      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
        return Home();
      default:
        return Login();
    }
  }
}