import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransferTypeWidget extends StatelessWidget {
  final String icon;
  final String label;
  final bool checked;
  final bool bordered;

  TransferTypeWidget(
      {this.checked = false, this.label, this.icon, this.bordered = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 24, right: 33, top: 26, bottom: 27),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: bordered ? Border.all(color: Color(0xff0080b1)) : null,
        color: checked ? Color(0xff0080b1) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0x29000000),
            offset: Offset(0, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                child: SvgPicture.asset(icon),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  label,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 12,
                    color: checked ? Colors.white : Color(0xff0080b1),
                    fontWeight: FontWeight.w600,
                    height: 1.6666666666666667,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          FittedBox(
            child: Container(
              width: 19.17,
              height: 19.17,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: checked
                  ? SvgPicture.asset('assets/svg_icons/check_selected.svg')
                  : SvgPicture.asset(
                      'assets/svg_icons/check_circle.svg',
                    ),
            ),
          )
        ],
      ),
    );
  }
}
