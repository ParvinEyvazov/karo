import 'package:flutter/material.dart';
import 'package:karo_app/ui/explore_page.dart';
import 'package:karo_app/ui/profile_page.dart';
import 'package:karo_app/ui/timeline_page.dart';

class HomaPage extends StatefulWidget {
  @override
  _HomaPageState createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  int secilenMenuItem = 0;

  List<Widget> allPages;

  TimelinePage inListTimelinePage;
  ExplorePage inListExplorePage;
  ProfilePage inListProfilePage;

  @override
  void initState() {
    super.initState();

    inListTimelinePage = TimelinePage();
    inListExplorePage = ExplorePage();
    inListProfilePage = ProfilePage();

    allPages = [inListTimelinePage, inListExplorePage, inListProfilePage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //  appBar: AppBar(
      //    title: Text("This is title"),
      //  ),
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
          activeIcon: Icon(Icons.home,color: Colors.black),
          backgroundColor: Colors.amber,
        ),
        //EXPLORE BOTTOM NAV BAR ICON
        BottomNavigationBarItem(
          title: Text("Explore"),
          icon: Icon(Icons.explore),
          activeIcon: Icon(Icons.explore,color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
        //PROFILE BOTTOM NAV BAR ICON
        BottomNavigationBarItem(
          title: Text("Profile"),
          icon: Icon(Icons.portrait),
          activeIcon: Icon(Icons.portrait,color: Colors.black),
          backgroundColor: Colors.cyan,
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
