import 'package:firebase_auth/firebase_auth.dart';

import 'database.dart';


abstract class AuthBase {
  Stream<User> authStateChanges();
  User get currentUser;
  //Future<User> signInAnonymously();
  Future<User> signInWithEmailAndPassword(String email, String password);
  Future<User> registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String mobile, String deviceToken);
  //Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;
  //  User _currentUser;
  // User get currentUser => _currentUser;
  @override
  Stream<User> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User get currentUser => _firebaseAuth.currentUser;


  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(), password: password);
    return userCredential.user;
  }
  @override
  Future<User> registerWithEmailAndPassword(String email, String password, String firstName, String lastName, String mobile, String deviceToken) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      // create a new document for the user with the uid
      await FirestoreDatabase(uid: user.uid).createUser(firstName, lastName, mobile, user.email, deviceToken);
      return userCredential.user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future sendPasswordResetEmail(String email) async{

    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future updateUserPassword(String password) async {


  }


  Future<bool> validatePassword(String password) async {
    var firebaseUser = _firebaseAuth.currentUser;

    var authCredentials = EmailAuthProvider.credential(
        email: firebaseUser.email, password: password);
    try {
      var authResult = await firebaseUser
          .reauthenticateWithCredential(authCredentials);
      return authResult.user != null;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updatePassword(String password) async {
    var firebaseUser = _firebaseAuth.currentUser;
    firebaseUser.updatePassword(password);
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
