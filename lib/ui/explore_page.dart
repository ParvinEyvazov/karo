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
            child: Text("Communities"),
          ),
          Container(
            color: Colors.indigo,
            child: Text("Events"),
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
}
