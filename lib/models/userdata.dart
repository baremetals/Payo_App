import 'package:flutter/material.dart';
import 'package:payo/models/user.dart';
import 'package:payo/services/auth.dart';
import 'package:provider/provider.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  @override
  Widget build(BuildContext context) {

    final users = Provider.of<List<User>>(context);
    //print(brews.documents);
    // users.forEach((user) {
    //   print(user.firstName);
    //   print(user.lastName);
    // });


  }
}