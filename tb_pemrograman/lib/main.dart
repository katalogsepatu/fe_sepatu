import 'package:flutter/material.dart';
import 'package:tb_pemrograman/Screens/HomePage.dart';
import 'package:tb_pemrograman/login_page.dart';

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
      routes: {
        "/": (context) => LoginPage(),
        "HomePage": (context) => HomePage(),
      },
    );
  }
}
