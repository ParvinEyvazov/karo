import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/bloc/user_bloc/bloc/user_bloc.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/ui/explore_page.dart';
import 'package:karo_app/ui/profile_page.dart';
import 'package:karo_app/ui/timeline_page.dart';

class HomePage extends StatefulWidget {
  int user_id;
  int aimPage;

  HomePage({@required this.user_id, this.aimPage});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int chosenPage = 0;

  List<Widget> allPages;

  var inListTimelinePage;
  var inListExplorePage;
  var inListProfilePage;

  @override
  void initState() {
    super.initState();
    if (widget.aimPage != null) {
      chosenPage = widget.aimPage;
    }

    //  ----------INSERT BLOC----------------
    inListTimelinePage = BlocProvider(
        create: (context) => EventBloc(),
        child: TimelinePage(user_id: widget.user_id));

    inListExplorePage = MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => CommunityBloc()),
      BlocProvider(create: (BuildContext context) => EventBloc())
    ], child: ExplorePage(user_id: widget.user_id));

    inListProfilePage = MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context) => UserBloc()),
    ], child: ProfilePage(user_id: widget.user_id));

    allPages = [inListTimelinePage, inListExplorePage, inListProfilePage];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: allPages[chosenPage],
      bottomNavigationBar: BottomNavMenu(),
    );
  }

  // BottomNavigationBar BottomNavMenu() {
  //   return BottomNavigationBar(
  //     currentIndex: chosenPage,
  //     type: BottomNavigationBarType.fixed,
  //     onTap: (index) {
  //       setState(() {
  //         chosenPage = index;
  //       });
  //     },
  //     backgroundColor: Colors.grey[100],
  //     items: <BottomNavigationBarItem>[
  //       BottomNavigationBarItem(
  //         title: Text("Timeline"),
  //         icon: Icon(Icons.home),
  //         activeIcon: Icon(Icons.home, color: Colors.black),
  //         backgroundColor: Colors.indigo,
  //       ),
  //       BottomNavigationBarItem(
  //         title: Text("Explore"),
  //         icon: Icon(Icons.explore),
  //         activeIcon: Icon(Icons.explore, color: Colors.black),
  //         backgroundColor: Colors.indigo,
  //       ),
  //       BottomNavigationBarItem(
  //         title: Text("Profile"),
  //         icon: Icon(Icons.portrait),
  //         activeIcon: Icon(Icons.portrait, color: Colors.black),
  //         backgroundColor: Colors.indigo,
  //       ),
  //     ],
  //   );
  // }

  ///OLD NAVBAR
  Widget BottomNavMenu() {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        //ITEMS
        items: <BottomNavigationBarItem>[
          //TIMELINE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Timeline"),
            icon: Icon(Icons.home, color: Colors.white38),
            activeIcon: Icon(Icons.home, color: Colors.white),
            backgroundColor: Color(0XFF306cbd),
          ),
          //EXPLORE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Explore"),
            icon: Icon(
              Icons.explore,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.explore, color: Colors.white),
            backgroundColor: Color(0XFF306cbd),
          ),
          //PROFILE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(
              Icons.portrait,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.portrait, color: Colors.white),
            backgroundColor: Color(0XFF306cbd),
          ),
        ],

        //show current clicked one
        currentIndex: chosenPage,

        //Shifting- > show name after click
        type: BottomNavigationBarType.shifting,

        onTap: (index) {
          setState(() {
            chosenPage = index;
          });
        },
      ),
    );
  }
}
