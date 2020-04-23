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
        //SHOW NAME
        Container(
          color: Colors.amber,
            padding: EdgeInsets.only(left: 22.0, top: 40.0, bottom: 35.0),
            child: Text("Welcome, Parvin!", style: TextStyle(fontSize: 32))),
        //DIVIDER
        Divider(color: Colors.black,thickness: 2.0,height: 2.0,),
        //LIST OF EVENTS
        card(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Nisan",
            place: "Meltem Kapisi"),
        card(
            eventName: "Java Egitimi",
            communityName: "IEEE",
            datetime: "16 Nisan",
            place: "Bodrum Kat"),
        card(
            eventName: "Microsoft Office Egitimi",
            communityName: "Akdeniz Bilgisayar Toplulugu",
            datetime: "21 Mayis",
            place: "Yazilim Lab 1"),
        card(
            eventName: "Web Tasarim",
            communityName: "IEEE",
            datetime: "18 Mayis",
            place: "Kantin"),
        card(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Mayis",
            place: "Meltem Kapisi"),
        card(
            eventName: "Java Egitimi",
            communityName: "IEEE",
            datetime: "16 Nisan",
            place: "Bodrum Kat"),
        card(
            eventName: "Microsoft Office Egitimi",
            communityName: "Akdeniz Bilgisayar Toplulugu",
            datetime: "21 Mayis",
            place: "Yazilim Lab 1"),
        card(
            eventName: "Web Tasarim",
            communityName: "IEEE",
            datetime: "18 Mayis",
            place: "Kantin"),
        card(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Mayis",
            place: "Meltem Kapisi"),
      ],
    );
  }

  Container card(
      {@required String eventName,
      @required String communityName,
      @required String datetime,
      @required String place}) {
    return Container(
      color: Colors.amber,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
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
                    Text(communityName,style: TextStyle(fontWeight: FontWeight.bold),)
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
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Text(
                "Lorem ipsum fusce eleifend egestas ipsum, nec auctor risus pellentesque non. "
                "Ut dictum gravida odio, ac malesuada risus accumsan vitae. Donec vel "
                "nibh ultrices, blandit metus ac, ultrices urna. Nullam vitae bibendum "
                "quam, rhoncus condimentum ipsum. In hac habitasse platea dictumst. "
                "Vivamus rhoncus justo a ex porta placerat. ",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
