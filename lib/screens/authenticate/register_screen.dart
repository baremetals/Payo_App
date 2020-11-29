import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payo/widgets/button.dart';
import 'package:payo/services/auth.dart';

import '../tab_screen.dart';


class RegisterScreen extends StatefulWidget {
  static const routeName = 'register-screen';
  final Function toggleView;
  RegisterScreen({ this.toggleView });

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  final Auth _auth = Auth();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final mobileController = TextEditingController();

  bool value = false;
  final _formKey = GlobalKey<FormState>();
  final FocusNode _firstNameFocusNode = FocusNode();
  final FocusNode _lastNameFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool loading = false;
  String error = '';
  final PreferredSizeWidget appBar = AppBar();

  void _firstNameEditingComplete() {
    FocusScope.of(context).requestFocus(_lastNameFocusNode);
  }
  void _lastNameEditingComplete() {
    FocusScope.of(context).requestFocus(_mobileFocusNode);
  }
  void _mobileEditingComplete() {
    FocusScope.of(context).requestFocus(_emailFocusNode);
  }
  void _emailEditingComplete() {
    FocusScope.of(context).requestFocus(_passwordFocusNode);
  }
  void _submit() async {
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      dynamic result = await _auth.registerWithEmailAndPassword(emailController.text, passwordController.text, firstNameController.text, lastNameController.text, mobileController.text);
      // Navigator.of(context)
      //     .pushNamed(ProfileScreen.routeName);
      if(result == null) {
        setState(() {
          loading = false;
          error = 'Please supply a valid email or password';

        });
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    print(RegisterScreen.routeName);
    print(appBar.preferredSize.height);

    return loading ? CircularProgressIndicator() : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.clear),
          color: Color(0xff1BAECB),
          onPressed: () => widget.toggleView()
        ),
      ),
      body: SafeArea(
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
                    'Join the movement ',
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
//                 Row(
//                   children: [
//                     Text(
//                       'As a business',
//                       style: TextStyle(
//                         fontFamily: 'SF Pro Display',
//                         fontSize: 18,
//                         color: const Color(0xff0b6182),
//                         fontWeight: FontWeight.w600,
//                         height: 1.1111111111111112,
//                       ),
// //                  textAlign: TextAlign.center,
//                     ),
//                     Spacer(),
//                     CupertinoSwitch(
//                       activeColor: Theme.of(context).primaryColor,
//                       onChanged: (value) {
//                         setState(() {
//                           this.value = value;
//                         });
//                       },
//                       value: value,
//                     ),
//                   ],
//                 ),
                Divider(
                  height: 3,
                ),
                SizedBox(height: 30),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)))),
                        child: TextFormField(
                          focusNode: _firstNameFocusNode,
                          controller: firstNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'First name',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              color: const Color(0xffa5abac),
                              height: 1.1111111111111112,
                            ),
                          ),
                          validator: (firstNameController) {
                            if (firstNameController.isEmpty) {
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _firstNameEditingComplete,
                          onChanged: (val) {
                            setState(() => firstNameController.text);
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)))),
                        child: TextFormField(
                          focusNode: _lastNameFocusNode,
                          controller: lastNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Last name',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              color: const Color(0xffa5abac),
                              height: 1.1111111111111112,
                            ),
                          ),
                          validator: (lastNameController) {
                            if (lastNameController.isEmpty) {
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _lastNameEditingComplete,
                          onChanged: (val) {
                            setState(() => lastNameController.text);
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)))),
                        child: TextFormField(
                          focusNode: _mobileFocusNode,
                          controller: mobileController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Mob no.',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              color: const Color(0xffa5abac),
                              height: 1.1111111111111112,
                            ),
                          ),
                          validator: (mobileController) {
                            if (mobileController.isEmpty) {
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _mobileEditingComplete,
                          onChanged: (val) {
                            setState(() => mobileController.text);
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)))),
                        child: TextFormField(
                          focusNode: _emailFocusNode,
                          controller: emailController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Your Email',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              color: const Color(0xffa5abac),
                              height: 1.1111111111111112,
                            ),
                          ),
                          validator: (emailController) => emailController.isEmpty ? 'This field is Required' : null,
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
                            setState(() => emailController.text);
                          },
                        ),
                      ),
                      //
                      Container(
                        margin: EdgeInsets.only(bottom: 30),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: Color(0xffEEEEEE)))),
                        child: TextFormField(
                          focusNode: _passwordFocusNode,
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Choose password',
                            hintStyle: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 18,
                              color: const Color(0xffa5abac),
                              height: 1.1111111111111112,
                            ),
                          ),
                            validator: (passwordController) => passwordController.length < 8 ? 'Enter a password 8+ characters long' : null,
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 18,
                            color: const Color(0xffa5abac),
                            height: 1.1111111111111112,
                          ),
                          textInputAction: TextInputAction.done,
                          onEditingComplete: _submit,
                          onChanged: (val) {
                            setState(() => passwordController.text);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 41, top: 33),
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {},
                    child: Text.rich(
                      TextSpan(
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 12,
                          color: const Color(0xffa5abac),
                          height: 1.5,
                        ),
                        children: [
                          TextSpan(
                            text: 'By continuing you accept our ',
                          ),
                          TextSpan(
                            text: 'Terms of Use',
                            style: TextStyle(
                              color: const Color(0xff1baecb),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: ' and \n',
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: const Color(0xff1baecb),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '.',
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // Expanded(),
                Button(
                  function: () async {
                   if (_formKey.currentState.validate()) {
                     setState(() => loading = true);
                     dynamic result = await _auth.registerWithEmailAndPassword(emailController.text, passwordController.text, firstNameController.text, lastNameController.text, mobileController.text);
                     // Navigator.of(context)
                     //     .pushNamed(ProfileScreen.routeName);
                      if(result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email or password';

                        });
                      }
                   }
                  },
                  borderRadius: 10,
                  title: 'Register',
                ),
                // AlertDialog(
                //   title: Text('Email or Password Error'),
                //   content: Text(error),
                // )
                SizedBox(height: 60),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
