import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:payo/models/user.dart';

import 'database.dart';

class User {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;

  User({@required this.uid, this.firstName, this.lastName, this.email, this.mobile});
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  //Future<User> currentUser();
  //Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String mobile);
  //Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {

  final _firebaseAuth = FirebaseAuth.instance;
   User _currentUser;
  User get currentUser => _currentUser;


  // create user obj based on firebase user
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid, email: user.email) : null;
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged
    //.map((FirebaseUser user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future<String> getCurrentUID() async {
    return (await _firebaseAuth.currentUser()).uid;
  }
  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _firebaseAuth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

// sign in with email and password
  @override
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final authResult = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    return _userFromFirebaseUser(authResult.user);
  }


// register with email and password
//   Future<User> registerWithEmailAndPassword(String email, String password) async {
//     try {
//       AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       FirebaseUser user = result.user;
//       // create a new document for the user with the uid
//       await FirestoreDatabase(uid: user.uid).updateUserData(, 'Doe', user.email, '', '');
//       return _userFromFirebaseUser(user);
//     } catch (error) {
//       print(error.toString());
//       return null;
//     }
//   }

  Future<User> registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String mobile) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await FirestoreDatabase(uid: user.uid).createUser(firstName, lastName, mobile, user.email);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


// sign out'
  @override
  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }


}
