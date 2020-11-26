import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payo/screens/authenticate/login_or_register_screen.dart';

import 'authenticate/login_screen.dart';

class GetStartedScreen extends StatelessWidget {
  static const routeName = 'get-started';
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
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.3,
              // ),
              Spacer(),
              SvgPicture.asset('assets/svg_icons/payo_logo.svg'),
              SizedBox(
                height: 30,
              ),
              Text(
                'Money\nTransfer\nMade simple',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 48,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                  height: 1,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22),
                child: Text(
                  'An Easy app to manage your all payment\nand finance related needs',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w400,
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 47,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(LoginOrRegisterScreen.routeName);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: const Color(0xffffffff),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 17,
                      color: const Color(0xff0080b1),
                      height: 1.1764705882352942,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(
                height: 31,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 14,
                          color: const Color(0xff1baecb),
                          height: 1.4285714285714286,
                        ),
                        children: [
                          TextSpan(
                            text: 'Already have account?',
                          ),
                          TextSpan(
                            text: ' Sign In',
                            style: TextStyle(
                              color: const Color(0xffffffff),
                              height: 1.4285714285714286,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
