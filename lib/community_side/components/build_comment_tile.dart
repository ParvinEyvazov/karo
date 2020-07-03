import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';

class BuildCommentTile extends StatelessWidget {
  int userId;
  String userName;
  String userSurname;
  int eventId;
  String dateTime;
  String text;
  int deleted;
  void Function() onPressed;

  BuildCommentTile(
      {@required this.userId,
      @required this.userName,
      @required this.userSurname,
      @required this.eventId,
      @required this.dateTime,
      @required this.text,
      @required this.deleted,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: CustomBoxDecoration().create(Colors.white, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "$userName $userSurname",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(dateTime),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(8),
                child: Text(text),
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: onPressed,
              )
            ],
          ),
          // Divider(
          //   color: Colors.black,
          // )
        ],
      ),
    );
  }
}
