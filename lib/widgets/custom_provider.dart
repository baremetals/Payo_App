import 'package:payo/services/auth.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
  final Auth auth;

  Provider({Key key, Widget child, this.auth}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static Provider of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider) as Provider);
}