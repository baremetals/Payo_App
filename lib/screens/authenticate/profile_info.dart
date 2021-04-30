import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:payo/models/user.dart';
import 'package:payo/screens/home_screen.dart';
//mport 'package:payo/services/auth.dart';
import 'package:payo/services/database.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/platform_alert.dialog.dart';
import 'package:provider/provider.dart';

import '../settings_screen.dart';
//import '../tab_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'profile_info-screen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState(uid: null);
}

class _ProfileScreenState extends State<ProfileScreen> {
  //final Auth _auth = Auth();

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  _ProfileScreenState({@required this.uid});

  final String uid;

  final firstNameController = TextEditingController();
  //final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final professionController = TextEditingController();

  String lastName = '';
  String mobile = '';

  bool value = false;
  final _formKey = GlobalKey<FormState>();

  final PreferredSizeWidget appBar = AppBar();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<DatabaseService>(context);
    User user = Provider.of<User>(context);
    //print(ProfileScreen.routeName);
    //print(appBar.preferredSize.height);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(Icons.more_horiz),
              color: Color(0xff1BAECB),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsScreen()),
                );
              })),
      body: StreamBuilder<UserData>(
          stream: FirestoreDatabase(uid: user.uid).user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserData userData = snapshot.data;
              //mobileController.text = userData.mobile != null ? userData.mobile : (mobileController.text ?? '');
              //mobileController.text = mobileController.text != null ? mobileController.text : (userData.mobile?? '');
              //mobileController.text = userData.mobile;
              //mobile = userData.mobile;
              return SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 10,
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40, top: 20),
                          child: Text(
                            ' Update Personal Info',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 22,
                              color: const Color(0xff1280b1),
                              fontWeight: FontWeight.bold,
                              height: 0.9090909090909091,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          children: [
                            SpWidget(),
                            SizedBox(height: 30),
                            Spacer(),
                          ],
                        ),
                        // Divider(
                        //   height: 3,
                        // ),
                        SizedBox(height: 30),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffEEEEEE)))),
                                  child: TextFormField(
                                      initialValue: userData.firstName,
                                      readOnly: true,
                                      //controller: firstNameController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'First Name',
                                        hintStyle: TextStyle(
                                          fontFamily: 'SF Pro Display',
                                          fontSize: 18,
                                          color: const Color(0xffa5abac),
                                          height: 1.1111111111111112,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'this field is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18,
                                        color: const Color(0xffa5abac),
                                        height: 1.1111111111111112,
                                      ),
                                      onChanged: (firstNameController) =>
                                          setState(() => firstNameController)),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffEEEEEE)))),
                                  child: TextFormField(
                                    initialValue: userData.lastName,
                                    readOnly: true,
                                    //controller: lastNameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18,
                                        color: const Color(0xffa5abac),
                                        height: 1.1111111111111112,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'this field is Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 18,
                                      color: const Color(0xffa5abac),
                                      height: 1.1111111111111112,
                                    ),
                                    onChanged: (val) =>
                                        setState(() => lastName = val),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffEEEEEE)))),
                                  child: TextFormField(
                                    initialValue: userData.email,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18,
                                        color: const Color(0xffa5abac),
                                        height: 1.1111111111111112,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'this field is Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 18,
                                      color: const Color(0xffa5abac),
                                      height: 1.1111111111111112,
                                    ),
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: (val) =>
                                        setState(() => emailController.text = val),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 30),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Color(0xffEEEEEE)))),
                                  child: TextFormField(
                                    initialValue: userData.mobile,
                                    //controller: mobileController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: '',
                                      hintStyle: TextStyle(
                                        fontFamily: 'SF Pro Display',
                                        fontSize: 18,
                                        color: const Color(0xffa5abac),
                                        height: 1.1111111111111112,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'this field is Required';
                                      } else {
                                        return null;
                                      }
                                    },
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Display',
                                      fontSize: 18,
                                      color: const Color(0xffa5abac),
                                      height: 1.1111111111111112,
                                    ),
                                    keyboardType: TextInputType.phone,
                                    onChanged: (val) =>
                                        setState(() => mobile = val),
                                  ),
                                ),

                                // Container(
                                //   margin: EdgeInsets.only(bottom: 30),
                                //   decoration: BoxDecoration(
                                //       border: Border(
                                //           bottom: BorderSide(
                                //               color: Color(0xffEEEEEE)))),
                                //   child: TextFormField(
                                //     initialValue: userData.profession,
                                //     decoration: InputDecoration(
                                //       border: InputBorder.none,
                                //       hintText: 'Profession',
                                //       hintStyle: TextStyle(
                                //         fontFamily: 'SF Pro Display',
                                //         fontSize: 18,
                                //         color: const Color(0xffa5abac),
                                //         height: 1.1111111111111112,
                                //       ),
                                //     ),
                                //     validator: (value) {
                                //       if (value.isEmpty) {
                                //         return 'this field is Required';
                                //       } else {
                                //         return null;
                                //       }
                                //     },
                                //     style: TextStyle(
                                //       fontFamily: 'SF Pro Display',
                                //       fontSize: 18,
                                //       color: const Color(0xffa5abac),
                                //       height: 1.1111111111111112,
                                //     ),
                                //     onChanged: (val) =>
                                //         setState(() => professionController.text),
                                //   ),
                                // ),
                              ],
                            )),
                        // Expanded(),
                        Button(
                          function: () async {
                            if (_formKey.currentState.validate()) {
                              final updateMyProfile = await PlatformAlertDialog(
                                title: 'Update',
                                content: 'Please confirm?',
                                cancelActionText: 'Cancel',
                                defaultActionText: 'Confirm',
                              ).show(context);
                              if (updateMyProfile == true) {
                                await FirestoreDatabase(uid: user.uid)
                                    .updateUserDetails(
                                  //firstNameController.text ?? userData.firstName,
                                  userData.firstName != null ? userData.firstName : (firstNameController.text ?? ''),
                                  userData.lastName != null ? userData.lastName : (lastName ?? ''),
                                  //lastName != null ? lastName : (userData.lastName ?? ''),
                                  'nas@jones.com',
                                  mobile ?? userData.mobile,
                                );
                                PlatformAlertDialog(
                                  title: 'Update',
                                  content: 'Your profile has been updated.',
                                  cancelActionText: '',
                                  defaultActionText: 'Close',
                                ).show(context);
                              }
                            } else {
                              return CircularProgressIndicator();
                            }
                          },
                          borderRadius: 10,
                          title: 'Submit',
                        ),

                        SizedBox(height: 60),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// Future<void> _confirmSignOut(BuildContext context) async {
//   final didRequestSignOut = await PlatformAlertDialog(
//     title: 'Update',
//     content: 'Are you sure you want to logout?',
//     cancelActionText: 'Cancel',
//     defaultActionText: 'Confirm',
//   ).show(context);
//   if (didRequestSignOut == true) {
//     if (_formKey.currentState.validate()) {
//       await FirestoreDatabase(uid: user.uid).updateUserDetails(
//           firstName ?? userData.firstName,
//           lastName ?? userData.lastName,
//           email ?? userData.email,
//           mobile ?? userData.mobile,
//           profession ?? userData.profession
//       );
//   }
//
// }
