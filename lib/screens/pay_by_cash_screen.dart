import 'package:flutter/material.dart';
import 'package:payo/screens/tab_screen.dart';
import 'package:payo/widgets/button.dart';

class PayByCashScreen extends StatelessWidget {
  static const routeName = 'pay_by_cash_screen';

  final PreferredSizeWidget appBar = AppBar(
    elevation: 0,
    // backgroundColor: Theme.of(context).backgroundColor,
  );

  @override
  Widget build(BuildContext context) {
    print('app bar ${appBar.preferredSize.height}');
    return Scaffold(
      // appBar: appBar,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          height: (MediaQuery.of(context).size.height) -
              appBar.preferredSize.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pay by cash',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 22,
                        color: const Color(0xff1280b1),
                        fontWeight: FontWeight.w700,
                        height: 0.9090909090909091,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      'Thank you for your request we will respond to you within 2hrs and arrange collection.',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 18,
                        color: const Color(0xff0b6182),
                        fontWeight: FontWeight.w600,
                        height: 1.5555555555555556,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              // Expanded(child: Column()),
              Container(
                child: Button(
                  title: 'Done',
                  borderRadius: 10,
                  function: () {
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
