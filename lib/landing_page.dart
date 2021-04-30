import 'package:firebase_auth/firebase_auth.dart';
import 'package:payo/screens/tab_screen.dart';
import 'package:flutter/material.dart';
import 'package:payo/services/auth.dart';
import 'package:payo/services/database.dart';
import 'package:provider/provider.dart';

import 'screens/authenticate/authenticate.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return StreamBuilder<User>(
        stream: auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Authenticate();
            }
            return Provider<User>.value(
              value: user,
              child: Provider<DatabaseService>(
                create: (_) => FirestoreDatabase(uid: user.uid),
                builder: (context, snapshot) {
                  // if (user.firstName == 'John' && user.lastName == 'Doe') {
                  //   return HomeScreen();
                  // }
                  return
                    TabScreen();
                },

              ),

            );
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
