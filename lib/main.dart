import 'package:flutter/material.dart';
import 'package:payo/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:payo/landing_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
        create: (context) => Auth(),
    child:  MaterialApp(
      title: 'Payo Beta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'SF Pro Display',
        primaryColor: Color(0xff0080B1),
        backgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    ),
    );
  }
}
