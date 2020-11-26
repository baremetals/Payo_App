import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IntroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            fontWeight: FontWeight.bold,
            height: 1,
          ),
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 22, bottom: 40),
          child: Text(
            'An Easy app to manage your all payment\nand finance related needs',
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
    );
  }
}
