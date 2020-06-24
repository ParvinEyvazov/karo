import 'package:flutter/material.dart';

class BuilAvatarContainer extends StatelessWidget {
  IconData icon;

  BuilAvatarContainer({@required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 24),
      width: 130,
      height: 130,
      decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadius.circular(65),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 4,
              blurRadius: 20,
            ),
          ]),
      child: Center(
        child: Icon(
          icon,
          size: 60,
          color: Colors.white,
        ),
      ),
    );
  }
}
