import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payo/screens/tab_screen.dart';

class ReferralCodeScreen extends StatefulWidget {
  static const routeName = 'referral-code-screen';

  @override
  _ReferralCodeScreenState createState() => _ReferralCodeScreenState();
}

class _ReferralCodeScreenState extends State<ReferralCodeScreen> {
  bool isSkipped = false;
  @override
  Widget build(BuildContext context) {
    print(ReferralCodeScreen.routeName);
    return Scaffold(
      backgroundColor: Colors.white,
//      appBar: AppBar(
//        leading: null,
//        backgroundColor: Colors.white,
//        elevation: 0,
//        title: Text(
//          'Registration Verification',
//          style: TextStyle(
//            fontFamily: 'SF Pro Display Bold',
//            fontSize: 22,
//            color: const Color(0xff0080b1),
//            fontWeight: FontWeight.w700,
//          ),
//          textAlign: TextAlign.left,
//        ),
//      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Referral Code',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 22,
                  color: const Color(0xff0080b1),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 39, bottom: 40),
                  child: Text(
                    'Please enter the referral code below',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 29,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w300,
                    ),
                    textAlign: TextAlign.left,
                  )),
              Text(
                'Referral Code',
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
                  ],
                ),
              ),
              if (isSkipped) ...[
                SizedBox(
                  height: 13,
                ),
                InkWell(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TabScreen.routeName),
                  child: Text(
                    'Referral code submitted',
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
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    isSkipped = true;
                    setState(() {});
                  },
                  child: Row(
                    children: [
                      Text(
                        'SKIP',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xff1baecb),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        margin: EdgeInsets.only(left: 5),
//            padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                              Radius.elliptical(9999.0, 9999.0)),
                          color: const Color(0xff1baecb),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
