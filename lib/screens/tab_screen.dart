import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payo/screens/transfer/Transfer_money_screen.dart';
import 'package:payo/screens/authenticate/profile_info.dart';
import 'package:payo/screens/home_screen.dart';
import 'package:payo/screens/invite_friends_screen.dart';
import 'package:payo/screens/transaction_history_screen.dart';




class TabScreen extends StatefulWidget {
  static const routeName = 'tab-screen';
  final int index;

  const TabScreen({Key key, this.index = 0}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {

  int currentIndex = 0;
  bool isSelected = false;

  final List<Widget> _page = [
    HomeScreen(),
    TransactionHistoryScreen(),
    TransferMoneyScreen(),
    InviteFriendsScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {

    print(TabScreen.routeName);
    return Scaffold(
      body: _page[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff1baecb),
        //selectedIconTheme property doesn't control on svg Icons
        // so i made it manually by put a condition on the color of the svgPicture
        selectedIconTheme: IconThemeData(
          color: Color(0xff1baecb),
          size: 20,
        ),
        currentIndex: currentIndex,
        onTap: (i) {
          setState(() {
            currentIndex = i;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/home.svg',
              color: currentIndex == 0 ? Color(0xff1baecb) : Color(0xff8c8c94),
            ),
            title: // Adobe XD layer: 'Dashboard' (text)
            Text(
              'Home',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                // color: const Color(0xff1baecb),
                fontWeight: FontWeight.w600,
                height: 2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/transactions.svg',
              color: currentIndex == 1 ? Color(0xff1baecb) : Color(0xff8c8c94),
            ),
            title: Text(
              'Transactions',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                // color: const Color(0xff8c8c94),
                fontWeight: FontWeight.w600,
                height: 2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/invite.svg',
              color: Colors.white,
            ),
            title: //Adobe XD layer: 'Dashboard' (text)
            Text(
              'Send',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                // color: const Color(0xff8c8c94),
                fontWeight: FontWeight.w600,
                height: 2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/invite.svg',
              color: currentIndex == 3 ? Color(0xff1baecb) : Color(0xff8c8c94),
            ),
            title: // Adobe XD layer: 'Dashboard' (text)
            Text(
              'Invite',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                // color: const Color(0xff8c8c94),
                fontWeight: FontWeight.w600,
                height: 2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/svg_icons/account.svg',
              color: currentIndex == 4 ? Color(0xff1baecb) : Color(0xff8c8c94),
            ),
            title: //Adobe XD layer: 'Dashboard' (text)
            Text(
              'Account',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 10,
                // color: const Color(0xff8c8c94),
                fontWeight: FontWeight.w600,
                height: 2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TransferMoneyScreen()),
          );
        },
        child: CircleAvatar(
          radius: 23,
          backgroundColor: Color(0xff1BCBA9),
          child: SvgPicture.asset(
            'assets/svg_icons/send.svg',
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
