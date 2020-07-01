import 'package:flutter/material.dart';

class BuildCommentTile extends StatelessWidget {
  String userName;
  String commentText;
  String dateTime;
  BuildCommentTile(
      {@required this.userName,
      @required this.commentText,
      @required this.dateTime});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 1),
            )
          ]),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.all(10),
            child: Text(
              userName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Text(commentText),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(10),
            child: Text(dateTime),
          )
        ],
      ),
    );
  }
}
