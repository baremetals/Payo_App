import 'package:flutter/material.dart';
import 'package:payo/widgets/intro_widget.dart';

import 'login_screen.dart';
import 'register_screen.dart';

class LoginOrRegisterScreen extends StatelessWidget {
  static const routeName = 'login_or_register';
  final PreferredSizeWidget appBar = AppBar(
    elevation: 0,
    // backgroundColor: Theme.of(context).backgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          height: MediaQuery.of(context).size.height -
              (appBar.preferredSize.height),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              IntroWidget(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    label: 'Log in',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                  ),
                  CustomButton(
                    label: 'Sign up',
                    function: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final Function function;
  CustomButton({this.label, this.function});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: const Color(0xffffffff),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17,
            color: const Color(0xff0080b1),
            height: 1.1764705882352942,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
