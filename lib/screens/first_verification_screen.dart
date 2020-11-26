import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payo/widgets/button.dart';

import '../screens/second_verification_screen.dart';

class FirstVerificationScreen extends StatefulWidget {
  static const routeName = 'first-verification-screen';

  @override
  _FirstVerificationScreenState createState() =>
      _FirstVerificationScreenState();
}

class _FirstVerificationScreenState extends State<FirstVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    print(FirstVerificationScreen.routeName);
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 20, top: 20, left: 30),
                  width: double.infinity,
                  decoration:
                  BoxDecoration(color: Theme.of(context).primaryColor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(
                            'assets/svg_icons/payo.svg',
                            alignment: Alignment.centerRight,
                          ),
                        ],
                      ),
                      Spacer(),
                      Text(
                        'Registration Verification',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 22,
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 13, bottom: 22),
                        child: Text(
                          'To successfully complete registration, we need to \nverify your phone number. ',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 14,
                            color: const Color(0xffffffff),
                            height: 1.4285714285714286,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 30, top: 50, right: 30),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please enter the mobile \nphone number',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 29,
                          color: const Color(0xff000000),
                          fontWeight: FontWeight.w300,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 27, bottom: 10),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xff000000),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: TextField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 37,
                                      color: const Color(0xff1baecb),
                                      fontWeight: FontWeight.w700,
                                    ),
                                    hintText: '+233'),
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 37,
                                  color: const Color(0xff1baecb),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Container(
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 37,
                                    color: const Color(0x1a000000),
                                    fontWeight: FontWeight.w700,
                                  ),
                                  hintText: '125874963',
                                ),
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 37,
                                  color: const Color(0x1a000000),
                                  fontWeight: FontWeight.w700,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(flex: 4),
                      Button(
                        title: 'Next',
                        borderRadius: 10,
                        function: () {
                          Navigator.of(context)
                              .pushNamed(SecondVerificationScreen.routeName);
                        },
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
