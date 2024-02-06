import 'package:flutter/material.dart';
// import 'package:tb_pemrograman/Screens/AddProduct_page.dart';
import 'package:tb_pemrograman/screens/Welcome_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFCEDDEE),
      ),
      home: const WelcomeCatalogPage(),
    );
  }
}
