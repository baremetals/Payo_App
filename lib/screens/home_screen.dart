import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:payo/models/transfers.dart';
import 'package:payo/models/user.dart';
import 'package:payo/screens/settings_screen.dart';
import 'package:payo/screens/transfer/Transfer_money_screen.dart';
import 'package:payo/services/auth.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/platform_alert.dialog.dart';
import 'package:provider/provider.dart';
import 'package:payo/widgets/badge.dart.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/transaction_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home-screen';
  HomeScreen({Key key, @required this.database}) : super(key: key);
  final DatabaseService database;
  final Auth _auth = Auth();

  //final database = Provider.of<DatabaseService>(context);

  void _modalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(30.0),
          topRight: const Radius.circular(30.0),
        ),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(32.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(30.0),
            topRight: const Radius.circular(30.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            GestureDetector(
              onTap: () =>
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()),
                  ),
              child: Text(
                'Settings',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 18,
                  color: const Color(0xff0B6182),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.7,
            ),
            SizedBox(height: 24),
            Text(
              'Help',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 18,
                color: const Color(0xff0B6182),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.7,
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () => _confirmSignOut(context),
              child: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'SF Pro Display',
                  fontSize: 18,
                  color: const Color(0xff1BAECB),
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 20),
            Divider(
              thickness: 0.7,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmSignOut(BuildContext context) async {
    //final Auth _auth = Auth();
    final didRequestSignOut = await PlatformAlertDialog(
      title: 'Logout',
      content: 'Are you sure you want to logout?',
      cancelActionText: 'Cancel',
      defaultActionText: 'Logout',
    ).show(context);
    if (didRequestSignOut == true) {
      await _auth.signOut();
    }
    //Navigator.of(context).pop();
    // Navigator.of(context)
    //     .pushNamed(SigninOrSignUpScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: FirestoreDatabase(uid: user.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            if (userData.firstName.length > 0) {}
            if (userData.lastName.length > 0) {}
            //print(userData);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color(0xffFAFAFA),
                elevation: 0,
                leading: InkWell(
                  onTap: () => _modalBottomSheetMenu(context),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Icon(
                      Icons.more_horiz,
                      color: Color(0xff1BAECB),
                    ),
                  ),
                ),
                actions: [
                  InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: CustomBadge(
                          value: null,
                        ),
                      )),
                ],
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userData.firstName + ' ' + userData.lastName,
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 22,
                                  color: const Color(0xff0080b1),
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personal account',
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 12,
                                      color: const Color(0xff1baecb),
                                      fontWeight: FontWeight.w700,
                                      height: 1.6666666666666667,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Color(0xff1BAECB),
                                    // size: 25,
                                    textDirection: TextDirection.ltr,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SpWidget()
                        ],
                      ),
                      DataWidget(
                          //time: '',
                          //date: 2:30,
                          //amountSent: 200,
                          ),
                      SizedBox(
                        height: 29,
                      ),
                      Button(
                        title: 'Transfer money',
                        borderRadius: 10,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TransferMoneyScreen()),
                          );
                        },
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 14,
                              color: const Color(0xff1280b1),
                              fontWeight: FontWeight.w700,
                              height: 1.4285714285714286,
                            ),
                            textAlign: TextAlign.left,
                          )

                          // InkWell(
                          //   onTap: () => Navigator.of(context).pushReplacement(
                          //     MaterialPageRoute(
                          //       builder: (context) => TabScreen(
                          //         index: 1,
                          //       ),
                          //     ),
                          //   ),
                          //   child: Text(
                          //     '',
                          //     style: TextStyle(
                          //       fontFamily: 'SF Pro Display',
                          //       fontSize: 14,
                          //       decoration: TextDecoration.underline,
                          //       color: const Color(0xff8c8c94),
                          //       height: 1.4285714285714286,
                          //     ),
                          //     textAlign: TextAlign.left,
                          //   ),
                          // ),
                        ],
                      ),
                      Divider(
                        thickness: 0.7,
                      ),
                      StreamBuilder<List<Transfer>>(
                          stream: database.transferStream(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final transfer = snapshot.data;
                              List<TransactionWidget> testWidgets = [];
                              final made = transfer.map((transfer) {
                                final receiverName = transfer.receiverName;
                                final status = transfer.status;
                                final amountSent = transfer.amountSent;
                                final dateSent = transfer.date.toDate().toString().replaceAll('-', '/').split(' ').elementAt(0);
                                final testWidget = TransactionWidget(
                                    name: receiverName,
                                    status: status,
                                    price: amountSent,
                                    dateSent: dateSent);
                                testWidgets.add(testWidget);
                                print(testWidget);
                              }).toList();
                              return SafeArea(
                                child: Column(
                                  children: testWidgets,
                                ),
                              );
                            }
                            return Center(child: CircularProgressIndicator());
                          }),
                    ],
                  ),
                ),
              ),
            );
            // }).toList();
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}

class SpWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    User user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: FirestoreDatabase(uid: user.uid).user,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
          //   final one = { if (userData.firstName.length > 0) {
          //     userData.firstName[0].toString()
          //   }
          // };
          //   final two = { if (userData.lastName.length > 0) {
          //     userData.lastName[0]
          //   }
          //   };

            if (userData.firstName.length > 0) {
              final firstInitial = userData.firstName[0];
              final secondInitial = userData.lastName[0];
            return CircleAvatar(
              radius: 35,
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  '$firstInitial' + '$secondInitial',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 24,
                    color: const Color(0xffa5abac),
                    fontWeight: FontWeight.w700,
                    height: 0.8333333333333334,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              backgroundColor: Color(0xffEAEAEA),
            );
          }
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}

class DataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    return StreamBuilder<List<Transfer>>(
        stream: database.transferStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('');
          } else {
            final transfer = snapshot.data;
            if (transfer.length > 0) {
              final currency =
                  transfer.map((transfer) => (transfer.sendingCurrency)).elementAt(0);
              final lastAmountSent = transfer
                  .map((transfer) => (transfer.amountSent))
                  .elementAt(0);
              final dateTime =
              transfer.map((transfer) => (transfer.date).toDate()).elementAt(0);
              final date1 = dateTime;
              final date2 = DateTime.now().difference(date1).inDays;

            // final can = {

            //   if (date2 >= 7) {
            //     'days ago'
            //   } else if(date2 >= 14)
            //     'weeks ago'
            //   else if (date2 >= 56)
            //       'months ago'
            //
            // }.toSet();

            //print(learn);
            //print(dateTime);
            return Container(
              margin: EdgeInsets.only(top: 48),
              padding: EdgeInsets.only(left: 23, right: 19),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xff0080b1),
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
                  Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$lastAmountSent' + ' $currency',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Last transfer $date2 days ago',
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 10,
                            color: const Color(0xffffffff),
                            height: 2,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg_icons/payo.svg',
                        width: 127,
                        height: 124,
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          }
          return Text('');
        });
  }
}

class DataWidgetT extends StatelessWidget {
  final String date;
  final double price;

  DataWidgetT({this.price, this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 48),
      padding: EdgeInsets.only(left: 23, right: 19),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: const Color(0xff0080b1),
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
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$price GHS',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 16,
                    color: const Color(0xffffffff),
                    fontWeight: FontWeight.w700,
                    height: 1.25,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Last transfer $date',
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 10,
                    color: const Color(0xffffffff),
                    height: 2,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/svg_icons/payo.svg',
                width: 127,
                height: 124,
              ),
            ],
          )
        ],
      ),
    );
  }
}
