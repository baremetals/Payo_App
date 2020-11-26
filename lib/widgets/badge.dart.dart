import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    Key key,
    @required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 40,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg_icons/alarm.svg',
            width: 17,
            height: 25
          ),
          Positioned(
            bottom: 26,
            right: 0,
            left: 9,
            child: Badge(
              shape: BadgeShape.circle,
              padding: EdgeInsets.all(3),
              toAnimate: false,
              badgeColor: Color(0xff1BCBA9),
              badgeContent: Text(
                '11',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 11,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
