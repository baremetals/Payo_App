
import 'package:flutter/material.dart';
import 'package:payo/screens/authenticate/login_screen.dart';
import 'package:payo/screens/authenticate/register_screen.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showLogin = true;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginScreen(toggleView:  toggleView);
    } else {
      return RegisterScreen(toggleView:  toggleView);
    }
  }
}