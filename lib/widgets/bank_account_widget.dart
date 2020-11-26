import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BankAccountWidget extends StatelessWidget {
//   final String bankName;
//   final String bankNumber;
//   final Function iconFunctoin;
//   final Widget icon;
// final Function listTileFinction
//
//   BankAccountWidget({
//     this.icon,
//     this.bankName,
//     this.bankNumber,
//     this.functoin
// });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.lightBlueAccent),
      child: ListTile(
        onTap: () {},
        leading: CircleAvatar(
          child: SvgPicture.asset('assets/svg_icons/friends.svg'),
          radius: 30,
          backgroundColor: Colors.white,
        ),
        title: Text(
          'HDFC Bank',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            height: 0.9090909090909091,
          ),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          '******5255',
          style: TextStyle(
            fontFamily: 'SF Pro Display',
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
            height: 0.9090909090909091,
          ),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: CircleAvatar(
          backgroundColor: Colors.blue,
          child: IconButton(
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {}),

          // radius: 25,
        ),
      ),
    );
  }
}
