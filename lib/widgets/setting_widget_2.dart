import 'package:flutter/material.dart';

class SecondSettingWidget extends StatelessWidget {
  final String title;


  SecondSettingWidget({this.title,});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title ,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff0b6182),
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),

              ],
            ),
            Icon(Icons.arrow_forward_ios,color: Color(0xff1BAECB),)
          ],
        ),
        SizedBox(
          height: 30,
        ),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }
}
