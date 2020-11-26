import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  Function function;
  String title;
  double borderRadius;
  Button({this.title, this.function, this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: const Color(0xff1baecb),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 17,
            color: const Color(0xffffffff),
            height: 1.1764705882352942,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
