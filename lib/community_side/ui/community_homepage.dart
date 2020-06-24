import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/community_side/bloc/community_add_event_bloc/bloc/community_add_event_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/bloc/community_profile_bloc/bloc/community_profile_bloc.dart';
import 'package:karo_app/community_side/ui/community_add_event_page.dart';
import 'package:karo_app/community_side/ui/community_events_page.dart';
import 'package:karo_app/community_side/ui/community_profile_page.dart';

class CommunityHomepage extends StatefulWidget {
  int community_id;
  CommunityHomepage({this.community_id});

  @override
  _CommunityHomepageState createState() => _CommunityHomepageState();
}

class _CommunityHomepageState extends State<CommunityHomepage> {
  int chosenPage = 0;

  List<Widget> allPages;

  var inListEventsPage;
  var inListCommunityProfilePage;
  var addNewEventPage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    inListEventsPage = BlocProvider(
      create: (context) => CommunityEventsBloc(),
      child: CommunityEventsPage(community_id: 8),
    );
    inListCommunityProfilePage = BlocProvider(
      create: (context) => CommunityProfileBloc(),
      child: CommunityProfilePage(),
    );
    addNewEventPage = BlocProvider(
      create: (context) => CommunityAddEventBloc(),
      child: CommunityAddEventPage(community_id: 8),
    );

    allPages = [
      inListEventsPage,
      addNewEventPage,
      inListCommunityProfilePage,
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: allPages[chosenPage],
      bottomNavigationBar: BottomNavMenu(),
    );
  }

  BottomNavigationBar BottomNavMenu() {
    return BottomNavigationBar(
      currentIndex: chosenPage,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          chosenPage = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          title: Text("Events"),
          icon: Icon(Icons.event),
          activeIcon: Icon(Icons.event, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
        BottomNavigationBarItem(
          title: Text("Add"),
          icon: Icon(Icons.add),
          activeIcon: Icon(Icons.add, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
        BottomNavigationBarItem(
          title: Text("Profile"),
          icon: Icon(Icons.people),
          activeIcon: Icon(Icons.people, color: Colors.black),
          backgroundColor: Colors.indigo,
        ),
      ],
    );
  }
}
