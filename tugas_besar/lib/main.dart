import 'package:flutter/material.dart';
import 'package:tugas_besar/UI/home/homeScreen.dart';
import 'package:tugas_besar/UI/launcher/launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tugas_besar/UI/login/login_screen.dart';
import 'package:tugas_besar/UI/product/detailProduct/detailProduct_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan Flutter',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
      ),
      home: LoginScreen(),
    );
  }
}
