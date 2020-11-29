import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payo/services/auth.dart';
import 'package:payo/widgets/platform_alert.dialog.dart';
import 'package:payo/widgets/setting_widget_2.dart';
import 'package:payo/widgets/settings_widget.dart';
import 'authenticate/profile_info.dart';
import 'authenticate/login_or_register_screen.dart';



class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';
  final Auth _auth = Auth();

  Future<void> confirmSignOut(BuildContext context) async {
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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginOrRegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              confirmSignOut(context);
            },
            child: Icon(
              Icons.clear,
              color: Color(0xff1BAECB),
            )),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 22,
                color: const Color(0xff1280b1),
                fontWeight: FontWeight.w700,
                height: 0.9090909090909091,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40),
            SettingWidget(
              title: 'Change Email',
              subtitle: 'johndoe@gmail.com (Verified)',
            ),
            SizedBox(height: 20),
            SettingWidget(
              title: 'Change Password',
              subtitle: '',
            ),
            SizedBox(height: 20),
            SecondSettingWidget(
              title: 'Notification preferences',
            ),
            SizedBox(height: 20),
            SecondSettingWidget(
              title: 'Report a bug',
            ),
            SizedBox(height: 20),
            SecondSettingWidget(
              title: 'About',
            ),
            SizedBox(height: 20),
            SecondSettingWidget(
              title: 'Privacy Policy',
            ),
            SizedBox(height: 20),
            Text(
              'Version: 1.0',
              style: TextStyle(
                fontFamily: 'SF Pro Display',
                fontSize: 14,
                color: const Color(0xff8c8c94),
                fontWeight: FontWeight.w600,
                height: 1.4285714285714286,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
