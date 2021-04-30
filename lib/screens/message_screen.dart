//import 'dart:io';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:payo/services/database.dart';
import 'package:payo/models/notifications.dart';
import 'package:provider/provider.dart';

final _firebaseAuth = FirebaseAuth.instance;
User get currentUser => _firebaseAuth.currentUser;

class MessageScreen extends StatefulWidget {
  static const routeName = 'message-screen';
  final String title = 'Notifications';

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final _firestore = FirebaseFirestore.instance;
  //final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  //final List<Message> messages = [];
  //List<Message> messagesList;
  //var token;

  // _getToken() {
  //   _firebaseMessaging.getToken().then((token) {
  //     print("Device Token: $token");
  //   });
  // }

  // void initState(){
  //   super.initState();
  //   _getToken();
  //   _firebaseMessaging.configure(
  //       onMessage: (Map<String, dynamic> message) async {
  //         print('onMessage: $message');
  //         final notification = message['notification'];
  //         setState(() {
  //           messages.add(Message(title: notification('title'), body: notification('body')));
  //         });
  //       },
  //
  //       onLaunch: (Map<String, dynamic> message) async {
  //         print('onLaunch: $message');
  //       },
  //
  //       onResume: (Map<String, dynamic> message) async {
  //         print('onResume: $message');
  //       }
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true)
  //   );
  // }

  // _configureFirebaseListeners() {
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('onMessage: $message');
  //       _setMessage(message);
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('onLaunch: $message');
  //       _setMessage(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print('onResume: $message');
  //       _setMessage(message);
  //     },
  //   );
  //   _firebaseMessaging.requestNotificationPermissions(
  //     const IosNotificationSettings(sound: true, badge: true, alert: true),
  //   );
  // }

  // _setMessage(Map<String, dynamic> message) {
  //   final notification = message['notification'];
  //   final data = message['data'];
  //   final String title = notification['title'];
  //   final String body = notification['body'];
  //   String mMessage = data['message'];
  //   print("Title: $title, body: $body, message: $mMessage");
  //   setState(() {
  //     Message msg = Message(title, body, mMessage);
  //     messagesList.add(msg);
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   messagesList = List<Message>();
  //   _getToken();
  //   _configureFirebaseListeners();
  // }

  getNotifications() async {
    QuerySnapshot snapshot = await userCollection
        .doc()
        .collection('notifications')
        .orderBy('timestamp', descending: true)
        .limit(50)
        .get();
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final uid = currentUser.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: _firestore.collection('users').doc(uid).collection('notifications').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final notices = snapshot.data.documents;
            List<Text> noticeWidgets = [];
            for (var message in notices) {
              final alert = message.get('alert');
              final date = message.get('date').toString().split(',');
              print(date.sublist(0, 1));


              //DateTime.parse(date);
              final noticeWidget = Text('$alert date: $date');
              noticeWidgets.add(noticeWidget);
              //print(noticeWidget);
            }

            // final notice = notices.map((notices) {
            //   final alert = notices.alert;
            //   // final body = notices.body;
            //   // final message = notices.message;
            //   final dateSent =
            //       notices.date.toDate().toString().split(' ').elementAt(0) ??
            //           '';
            //   final noticeWidget = Text('$alert $dateSent: dateSent');
            //   noticeWidgets.add(noticeWidget);
            // }).toList();
            print(notices);
            return SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(25),
                            topLeft: Radius.circular(25),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notifications',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Display',
                                    fontSize: 22,
                                    color: const Color(0xff1280b1),
                                    fontWeight: FontWeight.w700,
                                    height: 0.9090909090909091,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                // InkWell(
                                //   onTap: () {},
                                //   child: Icon(
                                //     Icons.search,
                                //     color: Color(0xff0080B1),
                                //   ),
                                // ),
                              ],
                            ),
                            Divider(
                              thickness: 0.7,
                            ),
                            Expanded(
                              child: ListView(
                                children: noticeWidgets,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
