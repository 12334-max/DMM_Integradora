import 'package:flutter/material.dart';
import 'package:productos_nube/src/pages/Home_page.dart';
import 'package:productos_nube/src/pages/lista_pages.dart';
import 'package:productos_nube/src/pages/producto_pages.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (_) => HomePages(),
        'lista': (_) => ListaPages(),
        'producto': (_) => ProductoPage(),
      },
    );
  }
}
