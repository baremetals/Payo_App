import 'package:flutter/material.dart';

class SettingWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  SettingWidget({this.title, this.subtitle});
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),

                  //TODO : overflow
                  child: Text(
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
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 14,
                    color: Color(0xff8C8C94),
                    fontWeight: FontWeight.w600,
                    height: 1.4285714285714286,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            // InkWell(
            //   onTap: () {},
            //   child: Icon(
            //     Icons.arrow_forward_ios,color: Color(0xff1BAECB),),
            // )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          thickness: 0.7,
        ),
      ],
    );
  }
}
