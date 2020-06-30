import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
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
            Container(
              color: Colors.blueGrey.shade400,
              child: BlocBuilder(
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
            ),

            //-------------------------EVENT SIDE-------------------------
            Container(
              color: Colors.blueGrey.shade400,
              child: BlocBuilder(
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
                                  eventName: state.event_list[index].eventTitle,
                                  communityName:
                                      state.event_list[index].community_name,
                                  datetime:
                                      state.event_list[index].eventDateTime,
                                  place: state.event_list[index].eventLocation,
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
                  }),
            )
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
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ListTile(
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
            title: Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  communityName,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            subtitle: Container(
              padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
              child: Text(communityDesc),
            ),
          ),
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
      color: Colors.blueGrey.shade400,
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: ListTile(
            onTap: () {
              //going to single event page
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
            //Title part
            //include -> ROW(column1(event name , community) , column2(datatime, place))
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // EVENT NAME & COMMUNITY NAME
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      eventName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      communityName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          datetime,
                          maxLines: 1,
                          style: TextStyle(fontSize: 13),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.place),
                            Flexible(
                              child: Text(
                                place,
                                style: TextStyle(fontSize: 13),
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            subtitle: Container(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Text(
                desc,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TabBar tabBarMethodu() {
    return TabBar(
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
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
