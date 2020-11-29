import 'package:flutter/material.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/services/auth.dart';
import 'package:payo/widgets/platform_alert.dialog.dart';

import 'forgot_password.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'login-screen';
  final Function toggleView;
  LoginScreen({ this.toggleView });

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final Auth _auth = Auth();
  final _formKey = GlobalKey<FormState>();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool loading = false;

  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }

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
    print(LoginScreen.routeName);
    return loading ? CircularProgressIndicator() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () => widget.toggleView(),
          child: Icon(
            Icons.clear,
            color: Color(0xff1BAECB),
          ),
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
                  'Login',
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
                  textInputAction: TextInputAction.next,
                  onEditingComplete: _emailEditingComplete,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Color(0xffEEEEEE)))),
                child: TextFormField(
                  focusNode: _passwordFocusNode,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      fontFamily: 'SF Pro Display',
                      fontSize: 18,
                      color: const Color(0xffa5abac),
                      height: 1.1111111111111112,
                    ),
                  ),
                  validator: (val) => val.length < 8 ? 'Enter a password 8+ characters long' : null,
                  style: TextStyle(
                    fontFamily: 'SF Pro Display',
                    fontSize: 18,
                    color: const Color(0xffa5abac),
                    height: 1.1111111111111112,
                  ),
                    textInputAction: TextInputAction.done,
                    onEditingComplete: _submit,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              SizedBox(
                height: 43,
              ),
              Button(
                title: 'Login',
                borderRadius: 100,
                function: () async {
                  if (_formKey.currentState.validate()) {
                    setState(() => loading = true);
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      PlatformAlertDialog(
                        title: 'sign in failed',
                        content: error.toString(),
                        defaultActionText: 'OK',
                      ).show(context);
                      setState(() {
                        error = 'Could not sign in with the email and password provided';
                        loading = false;
                      });
                    }
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
                        MaterialPageRoute(builder: (context) => ForgotPassword()),
                      );
                      // Navigator.of(context).pushNamed(ForgotPassword.routeName);
                    },
                    child: Text(
                      'Forgot password',
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
