import 'package:flutter/material.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';

class BuildEventListTile extends StatelessWidget {
  void Function() onTap;
  String eventName;
  String communityName;
  String datetime;
  String address;
  String description;

  BuildEventListTile(
      {@required this.onTap,
      @required this.eventName,
      @required this.communityName,
      @required this.datetime,
      @required this.address,
      @required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBoxDecoration().create(Colors.white, 10),
      child: ListTile(
        onTap: onTap,
        //Title part
        //include -> ROW(column1(event name , community) , column2(datatime, place))
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // EVENT NAME & COMMUNITY NAME
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  eventName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  communityName,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      datetime,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Icon(
                          Icons.place,
                          color: Color(0XFF306cbd),
                        ),
                        Flexible(
                          child: Text(
                            address,
                            style: TextStyle(fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),

        subtitle: Container(
          padding: EdgeInsets.only(top: 15, bottom: 20),
          child: Text(
            description,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
