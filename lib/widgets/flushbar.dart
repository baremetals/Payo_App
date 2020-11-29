import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';


class MyFlushbarAlert extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'test',
      home: Container(
        child: Center(
          child: MaterialButton(
            onPressed: () {
              Flushbar(
                title: "Yellow man dem",
                message: "Forever young I will be",
                duration: Duration(seconds: 3),
              )..show(context);
            },
          ),
        ),
      ),
    );
  }

  void transferFlushbar(BuildContext context) {
    Flushbar(
      message: 'just testing this rasclart',
      mainButton: FlatButton(
        child: Text(
          'Click Me',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
        onPressed: () {},
      ),
      duration: Duration(seconds: 3),
    )..show(context);
  }
}

