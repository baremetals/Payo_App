import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/referral_code_screen.dart';

class SecondVerificationScreen extends StatefulWidget {
  static const routeName = 'second-verificarion-screen';

  @override
  _SecondVerificationScreenState createState() =>
      _SecondVerificationScreenState();
}

class _SecondVerificationScreenState extends State<SecondVerificationScreen> {
  bool isVerified = false;

  @override
  Widget build(BuildContext context) {
    print(SecondVerificationScreen.routeName);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Registration Verification',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 22,
                  color: const Color(0xff0080b1),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 39, bottom: 30),
                child: Text(
                  'Please enter the OTP sent \non your mobile phone number',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 29,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                'Verification Code',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 18,
                  color: const Color(0xffa5abac),
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                height: 10,
              ),
              Form(
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: 49.0,
                      margin: EdgeInsets.only(right: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffeaecef),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: 49.0,
                      margin: EdgeInsets.only(right: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffeaecef),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 13),
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: 49.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffeaecef),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
//                  height: 49.0,
                      margin: EdgeInsets.only(right: 13),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffeaecef),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
//                  height: 49.0,
                      margin: EdgeInsets.only(right: 13),

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: const Color(0xffeaecef),
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 18,
                          color: const Color(0xffa5abac),
                          height: 1.1111111111111112,
                        ),
                        textAlign: TextAlign.center,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'this field is Required';
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ),
              if (isVerified) ...[
                SizedBox(height: 24),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(ReferralCodeScreen.routeName),
                  child: Text(
                    'Account verified',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 18,
                      color: const Color(0xff00b196),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ] else ...[
                SizedBox(
                  height: 60,
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      width: 26.0,
                      height: 26.0,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                        color: const Color(0xff1baecb),
                      ),
                      child: SvgPicture.asset('assets/svg_icons/again.svg'),
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    InkWell(
                      onTap: () {
                        isVerified = true;
                        setState(() {});
                      },
                      child: Text(
                        'SEND AGAIN',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xff1baecb),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
