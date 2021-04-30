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

  void showInfoFlushbar(BuildContext context) {
    Flushbar(
      title: 'Info flush bar',
      message: 'just testing this rasclart',
      icon: Icon(
        Icons.info_outline,
        size: 28,
        color: Colors.blue.shade300,
      ),
      leftBarIndicatorColor: Colors.blue.shade300,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  // void showFloatingFlushbar(BuildContext context) {
  //   Flushbar(
  //     margin: EdgeInsets.all(10),
  //     borderRadius: 8,
  //     backgroundGradient: LinearGradient(
  //       //colors: [Colors.green.shade800, Colors.greenAccent.shade700],
  //       //stops: [0.6, 1],
  //     ),
  //     boxShadows: [
  //       BoxShadow(
  //         color: Colors.black45,
  //         offset: Offset(3, 3),
  //         blurRadius: 3,
  //       ),
  //     ],
  //     dismissDirection: FlushbarDismissDirection.HORIZONTAL,
  //     forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
  //     title: 'The default curve is Curves.easeOut',
  //     message: 'dismissDirection allows you to swipe left or right instead on the default down',
  //   )..show(context);
  // }

}

