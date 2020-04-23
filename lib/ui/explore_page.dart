import 'package:flutter/material.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage>
    with SingleTickerProviderStateMixin {
  var _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: tabBarMethodu(),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          //Communities
          Container(
            color: Colors.blue,
            child: allCommunities(),
          ),
          Container(
            color: Colors.indigo,
            child: allEvents(),
          )
        ],
      ),
    );
  }

  TabBar tabBarMethodu() {
    return TabBar(controller: _tabController, tabs: [
      Tab(
        icon: Icon(Icons.offline_bolt),
        text: "Communities",
      ),
      Tab(
        icon: Icon(Icons.event),
        text: "Events",
      )
    ]);
  }

//---------------ABOUT COMMUNITIES----------
  ListView allCommunities() {
    return ListView(
      children: <Widget>[
        cardCommunity(communityName: "AKUBIT"),
        cardCommunity(communityName: "IEEE"),
        cardCommunity(communityName: "Bilgisayar Muhendisligi"),
        cardCommunity(communityName: "Mimarlik"),
        cardCommunity(communityName: "Sanat"),
      ],
    );
  }

  Container cardCommunity({@required String communityName}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
            title: Container(padding: EdgeInsets.only(top: 10),child: Text(communityName,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
            subtitle: Container(
              padding: EdgeInsets.only(top: 15.0,bottom: 20.0),
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. "
              "Quisque consequat tincidunt condimentum. Suspendisse quis velit purus. Aenean "
              "faucibus rhoncus diam, a suscipit nunc varius at. Donec vel cursus orci. Donec "
              "gravida vulputate tortor eu egestas. Curabitur ornare, mi in maximus vehicula, "
              "sapien mi luctus ante, a sollicitudin ex lectus vitae eros. "),
            ),
          ),
        ),
      ),
    );
  }

//---------------ABOUT EVENTS----------------
  ListView allEvents() {
    return ListView(
      children: <Widget>[
        cardEvent(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Nisan",
            place: "Meltem Kapisi"),
        cardEvent(
            eventName: "Java Egitimi",
            communityName: "IEEE",
            datetime: "16 Nisan",
            place: "Bodrum Kat"),
        cardEvent(
            eventName: "Microsoft Office Egitimi",
            communityName: "Akdeniz Bilgisayar Toplulugu",
            datetime: "21 Mayis",
            place: "Yazilim Lab 1"),
        cardEvent(
            eventName: "Web Tasarim",
            communityName: "IEEE",
            datetime: "18 Mayis",
            place: "Kantin"),
        cardEvent(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Mayis",
            place: "Meltem Kapisi"),
        cardEvent(
            eventName: "Java Egitimi",
            communityName: "IEEE",
            datetime: "16 Nisan",
            place: "Bodrum Kat"),
        cardEvent(
            eventName: "Microsoft Office Egitimi",
            communityName: "Akdeniz Bilgisayar Toplulugu",
            datetime: "21 Mayis",
            place: "Yazilim Lab 1"),
        cardEvent(
            eventName: "Web Tasarim",
            communityName: "IEEE",
            datetime: "18 Mayis",
            place: "Kantin"),
        cardEvent(
            eventName: "Bisiklet turu",
            communityName: "Akdeniz Bisiklet",
            datetime: "14 Mayis",
            place: "Meltem Kapisi"),
      ],
    );
  }

  //AN EVENT CARD
  Container cardEvent(
      {@required String eventName,
      @required String communityName,
      @required String datetime,
      @required String place}) {
    return Container(
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
                //EVENT DATETIME & EVENT PLACE
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
                "Lorem Ipsum is simply dummy text of the printing and "
                "typesetting industry. Lorem Ipsum has been the industry's standard "
                "dummy text ever since the 1500s, when an unknown printer took a galley "
                "of type and scrambled it to make a type.",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
