import 'package:flutter/material.dart';

class BuildAddEventButton extends StatelessWidget {
  final blueColor = Color(0XFF5e92f3);
  final yellowColor = Color(0XFFfdd835);

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
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "ADD EVENT",
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
