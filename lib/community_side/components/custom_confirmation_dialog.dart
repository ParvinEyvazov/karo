import 'package:flutter/material.dart';

class CustomConfirmationDialog {
  void Function() onPressedYes;
  void Function() onPressedNo;

  CustomConfirmationDialog(
      {@required this.onPressedYes, @required this.onPressedNo});

  build(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: const Text('Are you sure?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: onPressedYes,
            ),
            FlatButton(
              child: Text('No'),
              onPressed: onPressedNo,
            ),
          ],
        );
      },
    );
  }
}
