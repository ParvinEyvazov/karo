import 'package:flutter/material.dart';
import 'package:karo_app/utils/database_helper.dart';

class CustomSubmitButton extends StatelessWidget {
  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);

  Function onPressedFunction;
  String buttonName;
  Color buttonColor;
  Color buttonTextColor;

  CustomSubmitButton(
      {@required this.onPressedFunction,
      @required this.buttonName,
      @required this.buttonColor,
      @required this.buttonTextColor});

  @override
  GestureDetector build(BuildContext context) {
    return GestureDetector(
      onTap: onPressedFunction,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 50),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            buttonName,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
