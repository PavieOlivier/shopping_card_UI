///[INFO]
///Made by mabiala emile pavie olivier
///email:paviemabiala@gmail.com
///email2: contact@emilecode.com
///instagram: emilecode
///For any question feel free to contact me
import 'package:flutter/material.dart';
import 'package:shoppingcard/Screen/HomeScreen/HomePage.dart';
import 'package:flutter/services.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MaterialApp(
      title: 'Furniture App',
      home: HomeScreen(),
      //home: ProductDetailScreen(),
    );
  }
}

