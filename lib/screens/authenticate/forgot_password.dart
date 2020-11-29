import 'package:flutter/material.dart';
import 'package:payo/services/auth.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/widgets/platform_alert.dialog.dart';

import 'login_screen.dart';

class ForgotPassword extends StatefulWidget {
  static const routeName = 'forgot_password';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  bool loading = false;


  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.signInWithEmailAndPassword(email.trim(), password);
      if(result == null) {
        setState(() {
          error = 'Could not sign in with the email and password provided';
          loading = false;
        });
      }
    }
  }

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    print(ForgotPassword.routeName);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {}
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 20),
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 22,
                      color: const Color(0xff1280b1),
                      fontWeight: FontWeight.w700,
                      height: 0.9090909090909091,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                  child: TextFormField(
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Your email',
                      hintStyle: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 18,
                        color: const Color(0xffa5abac),
                        height: 1.1111111111111112,
                      ),
                    ),
                    validator: (val) => val.isEmpty ? 'This field is Required' : null,
                    style: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 18,
                      color: const Color(0xffa5abac),
                      height: 1.1111111111111112,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _submit,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Button(
                  title: 'Submit',
                  borderRadius: 100,
                  function: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.sendPasswordResetEmail(email);
                      print(" this is a fucking test bro");
                      PlatformAlertDialog(
                        title: 'Email Sent',
                        content: 'Please check your email to reset your password',
                        defaultActionText: 'OK',
                      ).show(context);
                      // if(result != null) {
                      //   PlatformAlertDialog(
                      //     title: 'Please check your email',
                      //     content: error.toString(),
                      //     defaultActionText: 'OK',
                      //   ).show(context);
                      //   setState(() {
                      //     error = '';
                      //     loading = false;
                      //   });
                      // }
                    }
                  },
                ),
                SizedBox(
                  height: 34,
                ),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 16,
                          color: const Color(0xff1baecb),
                          fontWeight: FontWeight.w700,
                          height: 1.125,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showDefaultSnackbar(BuildContext context) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(" "),
      action: SnackBarAction(
        label: "Click Me",
        onPressed: () {},
      ),
    )
  );
}