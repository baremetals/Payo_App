import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payo/widgets/button.dart';

class InviteFriendsScreen extends StatelessWidget {
  static const routeName = 'InviteFriendsScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff1BAECB),
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 30),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Invite your friends',
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
                  height: 90,
                ),
                Center(
                  child: SvgPicture.asset('assets/svg_icons/friends.svg'),
                ),
                SizedBox(
                  height: 40,
                ),
                Button(
                  borderRadius: 10,
                  title: 'Send invite',
                  function: () {
                    // Navigator.of(context)
                    //     .pushNamed(PayByManualBankTransferScreen.routeName);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
