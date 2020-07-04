import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/community_side/bloc/community_add_event_bloc/bloc/community_add_event_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/ui/add_event/community_add_event_page.dart';
import 'package:karo_app/community_side/ui/events/community_event_comments_page.dart';
import 'package:karo_app/community_side/ui/events/community_events_page.dart';
import 'package:karo_app/community_side/ui/profile/community_profile_page.dart';

class CommunityHomepage extends StatefulWidget {
  int community_id;
  int aimPage;
  CommunityHomepage({this.community_id, this.aimPage});

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

    if (widget.aimPage != null) {
      chosenPage = widget.aimPage;
    }

    inListEventsPage = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentBloc(),
        ),
        BlocProvider(
          create: (context) => CommunityEventsBloc(),
        )
      ],
      child: CommunityEventsPage(community_id: widget.community_id),
    );
    inListCommunityProfilePage = BlocProvider(
      create: (context) => CommunityBloc(),
      child: CommunityProfilePage(community_id: widget.community_id),
    );
    addNewEventPage = BlocProvider(
      create: (context) => CommunityAddEventBloc(),
      child: CommunityAddEventPage(community_id: widget.community_id),
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

  Widget BottomNavMenu() {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        //ITEMS
        items: <BottomNavigationBarItem>[
          //TIMELINE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Events"),
            icon: Icon(Icons.event, color: Colors.white38),
            activeIcon: Icon(Icons.event, color: Colors.white),
            backgroundColor: Color(0XFF306cbd),
          ),
          //EXPLORE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Add"),
            icon: Icon(
              Icons.add,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.add, color: Colors.white),
            backgroundColor: Color(0XFF306cbd),
          ),
          //PROFILE BOTTOM NAV BAR ICON
          BottomNavigationBarItem(
            title: Text("Profile"),
            icon: Icon(
              Icons.people,
              color: Colors.white38,
            ),
            activeIcon: Icon(Icons.people, color: Colors.white),
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
