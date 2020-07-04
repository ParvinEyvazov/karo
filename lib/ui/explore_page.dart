import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_community_list_tile.dart';
import 'package:karo_app/community_side/components/build_event_list_tile.dart';
import 'package:karo_app/ui/singlePages/SingleNonJoinedComEventPage.dart';
import 'package:karo_app/ui/singlePages/SingleNonJoinedCommunityPage.dart';

class ExplorePage extends StatefulWidget {
  int user_id;

  ExplorePage({this.user_id});

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
    //initialize BloC
    final _eventBloc = BlocProvider.of<EventBloc>(context);
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF306cbd),
        automaticallyImplyLeading: false,
        title: tabBarMethodu(),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            //-------------------------COMMUNITY SIDE-------------------------
            Stack(children: <Widget>[
              BuildBackgroundBottomCircle(Colors.blue),
              BlocBuilder(
                  bloc: _communityBloc,
                  builder: (context, CommunityState state) {
                    if (state is CommunityInitial) {
                      _communityBloc.add(FetchAllNonJoinedCommunityEvent(
                          user_id: widget.user_id));
                      return Center(child: CircularProgressIndicator());
                    }

                    if (state is AllCommunityLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    //------------MAIN PART------------
                    if (state is AllCommunityLoadedState) {
                      if (state.community_list.length == 0) {
                        return Center(
                          child: Text("You joined all communities"),
                        );
                      } else {
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              _communityBloc.add(
                                  FetchAllNonJoinedCommunityEvent(
                                      user_id: widget.user_id));
                            });
                          },
                          child: ListView.builder(
                              itemCount: state.community_list.length,
                              itemBuilder: (context, index) {
                                return cardCommunity(
                                    comm_id: state.community_list[index].commId,
                                    communityName:
                                        state.community_list[index].commName,
                                    communityDesc:
                                        state.community_list[index].commDesc);
                              }),
                        );
                      }
                    }

                    if (state is AllCommunityLoadErrorState) {
                      return Center(child: Text("ERROR"));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }),
            ]),

            //-------------------------EVENT SIDE-------------------------
            Stack(
              children: <Widget>[
                BuildBackgroundBottomCircle(Colors.blue),
                BlocBuilder(
                    bloc: _eventBloc,
                    builder: (context, EventState state) {
                      //----------INITIAL STATE- CALL AN EVENT----------
                      if (state is EventInitial) {
                        _eventBloc.add(FetchAllNonJoinedComEventsEvent(
                            user_id: widget.user_id));
                        return Center(child: CircularProgressIndicator());
                      }

                      //----------LOADING STATE----------
                      if (state is AllEventsLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }

                      //----------MAIN - LOADED STATE----------
                      if (state is AllEventsLoadedState) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {
                              _eventBloc.add(FetchAllNonJoinedComEventsEvent(
                                  user_id: widget.user_id));
                            });
                          },
                          child: ListView.builder(
                              itemCount: state.event_list.length,
                              itemBuilder: (context, index) {
                                return cardEvent(
                                    context: context,
                                    eventID: state.event_list[index].eventID,
                                    eventName:
                                        state.event_list[index].eventTitle,
                                    communityName:
                                        state.event_list[index].community_name,
                                    datetime:
                                        state.event_list[index].eventDateTime,
                                    place:
                                        state.event_list[index].eventLocation,
                                    desc: state.event_list[index].eventDesc);
                              }),
                        );
                      }

                      //----------LOAD ERROR STATE----------
                      if (state is AllEventsLoadErrorState) {
                        return Center(
                          child: Text("ERROR"),
                        );
                      }
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }

  //COMMUNITY CARD
  Container cardCommunity(
      {@required int comm_id,
      @required String communityName,
      @required String communityDesc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 10,
        shadowColor: Colors.blue[900],
        child: BuildCommunityListTile(
          onTap: () {
            Future(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MultiBlocProvider(
                          providers: [
                            //to show community info
                            BlocProvider(
                                create: (BuildContext context) =>
                                    CommunityBloc()),
                            //to show events
                            BlocProvider(
                              create: (BuildContext context) => EventBloc(),
                            ),
                          ],
                          child: SingleNonJoinedCommunityPage(
                              user_id: widget.user_id, comm_id: comm_id))));
            });
          },
          communityName: communityName,
          communityDescription: communityDesc,
        ),
      ),
    );
  }

  Container cardEvent(
      {@required BuildContext context,
      @required int eventID,
      @required String eventName,
      @required String communityName,
      @required String datetime,
      @required String place,
      @required String desc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 10,
        shadowColor: Colors.blue[900],
        child: BuildEventListTile(
          address: place,
          eventName: eventName,
          communityName: communityName,
          datetime: datetime,
          description: desc,
          onTap: () {
            Future(() {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiBlocProvider(
                          providers: [
                            BlocProvider(
                                create: (BuildContext context) =>
                                    CommentBloc()),
                            BlocProvider<EventBloc>(
                                create: (BuildContext context) => EventBloc())
                          ],
                          child: SingleNonJoinedComEventPage(
                              user_id: widget.user_id, event_id: eventID))));
            });
          },
          context: context,
          eventID: eventID,
        ),
      ),
    );
  }

  TabBar tabBarMethodu() {
    return TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.white38,
        controller: _tabController,
        tabs: [
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
