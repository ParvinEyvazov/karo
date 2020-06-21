import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/ui/explore_page.dart';
import 'package:karo_app/ui/profile_page.dart';
import 'package:karo_app/ui/timeline_page.dart';

class HomePage extends StatefulWidget {
  int user_id;

  HomePage({this.user_id});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int secilenMenuItem = 0;

  List<Widget> allPages;

  var inListTimelinePage;
  var inListExplorePage;
  ProfilePage inListProfilePage;

  @override
  void initState() {
    super.initState();

    //  ----------INSERT BLOC----------------
    inListTimelinePage = BlocProvider(
        create: (context) => EventBloc(),
        child: TimelinePage(user_id: widget.user_id));

    inListExplorePage = MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => CommunityBloc()),
      BlocProvider(create: (BuildContext context) => EventBloc())
    ], child: ExplorePage(user_id: widget.user_id));


    inListProfilePage = ProfilePage(user_id: widget.user_id);

    allPages = [inListTimelinePage, inListExplorePage, inListProfilePage];
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: allPages[secilenMenuItem],
      bottomNavigationBar: BottomNavMenu(),
    );
  }

  BottomNavigationBar BottomNavMenu() {
    return BottomNavigationBar(
      //ITEMS
      items: <BottomNavigationBarItem>[
        //TIMELINE BOTTOM NAV BAR ICON
        BottomNavigationBarItem(
          title: Text("Timeline"),
          icon: Icon(Icons.home),
          activeIcon: Icon(Icons.home, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
        //EXPLORE BOTTOM NAV BAR ICON
        BottomNavigationBarItem(
          title: Text("Explore"),
          icon: Icon(Icons.explore),
          activeIcon: Icon(Icons.explore, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
        //PROFILE BOTTOM NAV BAR ICON
        BottomNavigationBarItem(
          title: Text("Profile"),
          icon: Icon(Icons.portrait),
          activeIcon: Icon(Icons.portrait, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
      ],

      //show current clicked one
      currentIndex: secilenMenuItem,

      //Shifting- > show name after click
      type: BottomNavigationBarType.shifting,

      onTap: (index) {
        setState(() {
          secilenMenuItem = index;
        });
      },
    );
  }
}
