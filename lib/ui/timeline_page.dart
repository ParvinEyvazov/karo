import 'package:flutter/material.dart';

class TimelinePage extends StatefulWidget {
  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 22.0, top: 40.0, bottom: 35.0),
            child: Text("Welcome, Parvin!", style: TextStyle(fontSize: 32))),
        //LIST OF EVENTS
        card(eventName: "Bisiklet turu", communityName: "Akdeniz Bisiklet", datetime: "14 Nisan", place: "Meltem Kapisi"),
        card(eventName: "Java Egitimi", communityName: "IEEE", datetime: "16 Nisan", place: "Bodrum Kat"),
        card(eventName: "Microsoft Office Egitimi", communityName: "Akdeniz Bilgisayar Toplulugu", datetime: "21 Mayis", place: "Yazilim Lab 1"),
        card(eventName: "Web Tasarim", communityName: "IEEE", datetime: "18 Mayis", place: "Kantin"),
        card(eventName: "Bisiklet turu", communityName: "Akdeniz Bisiklet", datetime: "14 Mayis", place: "Meltem Kapisi"),
        card(eventName: "Java Egitimi", communityName: "IEEE", datetime: "16 Nisan", place: "Bodrum Kat"),
        card(eventName: "Microsoft Office Egitimi", communityName: "Akdeniz Bilgisayar Toplulugu", datetime: "21 Mayis", place: "Yazilim Lab 1"),
        card(eventName: "Web Tasarim", communityName: "IEEE", datetime: "18 Mayis", place: "Kantin"),
        card(eventName: "Bisiklet turu", communityName: "Akdeniz Bisiklet", datetime: "14 Mayis", place: "Meltem Kapisi"),

      ],
    );
  }

  Container card({@required String eventName,@required String communityName, @required String datetime, @required String place}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(    
        elevation: 4,  
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            //Title part
            //include -> ROW(column1(event name , community) , column2(datatime, place))
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // EVENT NAME & COMMUNITY NAME
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(eventName),
                    SizedBox(height: 5),
                    Text(communityName)
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(datetime),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.place),
                        Text(place),
                      ],
                    )
                  ],
                ),
              ],
            ),

            subtitle: Container(
              padding: EdgeInsets.only(top: 15,bottom: 20),
              child: Text("Lorem Ipsum is simply dummy text of the printing and "
              "typesetting industry. Lorem Ipsum has been the industry's standard "
              "dummy text ever since the 1500s, when an unknown printer took a galley "
              "of type and scrambled it to make a type.",style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
      ),
    );
  }
}
