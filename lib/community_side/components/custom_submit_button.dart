import 'package:flutter/material.dart';
import 'package:karo_app/utils/database_helper.dart';

class CustomSubmitButton extends StatelessWidget {
  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);

  Function onPressedFunction;
  String buttonName;

  CustomSubmitButton(
      {@required this.onPressedFunction, @required this.buttonName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          RaisedButton(
            color: yellowColor,
            elevation: 10,
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
            onPressed: onPressedFunction,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  buttonName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.arrow_right,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
