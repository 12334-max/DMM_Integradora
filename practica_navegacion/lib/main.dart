import 'package:flutter/material.dart';
import 'package:practica_navegacion/src/pages/Home.dart';
import 'package:practica_navegacion/src/pages/Login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Practica navegaciòn',
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: <String, WidgetBuilder>{
          "/": (context) => Login(),
          "/home": (context) => Home()
        });
  }
}
