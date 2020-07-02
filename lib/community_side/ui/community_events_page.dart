import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/community_side/bloc/community_event_comments_bloc/bloc/community_event_comments_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/community_side/ui/community_event_comments_page.dart';
import 'package:karo_app/community_side/ui/community_event_edit_page.dart';
import 'package:karo_app/models/event.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityEventsPage extends StatefulWidget {
  int community_id;
  CommunityEventsPage({this.community_id});

  @override
  _CommunityEventsPageState createState() => _CommunityEventsPageState();
}

class _CommunityEventsPageState extends State<CommunityEventsPage> {
  int selectedEvent = 0;
  final blueColor = Color(0XFF5e92f3);

  DatabaseHelper _databaseHelper;

  var silderController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityEventsBloc = BlocProvider.of<CommunityEventsBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _communityEventsBloc,
        builder: (context, CommunityEventsState state) {
          if (state is CommunityEventsInitial) {
            _communityEventsBloc.add(FetchCommunityEventsInfoEvent(
                community_id: widget.community_id));
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommunityEventsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommunityEventsLoadedState) {
            return Stack(
              children: <Widget>[
                BuildTopCircle(
                  offSetValue: 1.3,
                ),
                BuildBackgroundBottomCircle(blueColor),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.37,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "EVENTS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      BuildAvatarContainer(icon: Icons.event),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.25),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          state.events.length <= 0
                              ? Center(
                                  child: Text("THERE IS NO EVENT"),
                                )
                              : middlePart(
                                  context: context,
                                  title: state.events[selectedEvent].eventTitle,
                                  description:
                                      state.events[selectedEvent].eventDesc,
                                  dateTime:
                                      state.events[selectedEvent].eventDateTime,
                                  location:
                                      state.events[selectedEvent].eventLocation,
                                  quota: state.events[selectedEvent].quota,
                                  joinedUser: state.joined_members[
                                      state.events[selectedEvent].eventID],
                                  event_id: state.events[selectedEvent].eventID,
                                  event: state.events[selectedEvent]),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      ////////EVENTS LIST BOTTOM
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.events.length,
                                itemBuilder: (context, index) {
                                  return Dismissible(
                                    key: UniqueKey(),
                                    onDismissed: (direction) {
                                      setState(() {
                                        Future(() {
                                          showDeleteConfirmationDialog(
                                            state.events[index].eventID,
                                            _communityEventsBloc,
                                          );
                                        });
                                      });
                                    },
                                    direction: DismissDirection.horizontal,
                                    child: eventCard(
                                        context: context,
                                        eventName:
                                            state.events[index].eventTitle,
                                        communityName:
                                            state.events[index].community_name,
                                        tileIndex: index),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is CommunityEventsLoadErrorState) {
            return Center(child: Text("ERROR"));
          }
        },
      ),
    );
  }

  GestureDetector eventCard({
    @required BuildContext context,
    @required String eventName,
    @required String communityName,
    @required int tileIndex,
  }) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: selectedEvent != null && selectedEvent == tileIndex
                ? Colors.blueAccent
                : Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            onTap: () {
              setState(() {
                selectedEvent = tileIndex;
              });
            },
            //Title part
            //include -> ROW(column1(event name , community) , column2(datatime, place))
            title: Text(
              eventName,
              style: TextStyle(
                  fontSize: 20,
                  color: selectedEvent != null && selectedEvent == tileIndex
                      ? Colors.white
                      : Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  IconButton editButton(Event event) {
    return IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {
        Navigator.of(context).push(_createRoute(event, widget.community_id));
      },
    );
  }

  Route _createRoute(Event event, int community_id) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          CommunityEventEditPage(
        event: event,
        community_id: community_id,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Row middlePart(
      {@required BuildContext context,
      @required String title,
      @required String description,
      @required String dateTime,
      @required String location,
      @required int quota,
      @required int joinedUser,
      @required int event_id,
      @required Event event}) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Column(
          children: <Widget>[
//--------------TITLE AND QUOTA-----------
            Container(
              //height: 400,
              margin: EdgeInsets.only(left: 20, right: 20),
              padding: EdgeInsets.all(20),
              decoration: CustomBoxDecoration().create(blueColor, 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: editButton(event),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            //minWidth: 20.0,
                            maxWidth: 300.0,
                            //minHeight: 20.0,
                            maxHeight: 100.0,
                          ),
                          child: Flexible(
                            child: AutoSizeText(
                              title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 30.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        SizedBox(width: 10),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            //minWidth: 20.0,
                            maxWidth: 300.0,
                            //minHeight: 20.0,
                            maxHeight: 100.0,
                          ),
                          child: AutoSizeText(
                            "${joinedUser.toString()}/${quota.toString()}",
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

//--------------DESCRIPTION AND BOTTOM PART----------
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      spreadRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ]),
              child: Expanded(
                flex: 1,
                child: PageView(children: <Widget>[
                  infoPart(description, location, dateTime),
                  commentPart(event_id),
                ]),
              ),
            )
          ],
        ))
      ],
    );
  }

  Column infoPart(
    String description,
    String location,
    String dateTime,
  ) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 300.0,
                          maxWidth: 350.0,
                          minHeight: 30.0,
                          //maxHeight: 100.0,
                        ),
                        child: AutoSizeText(
                          description,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.place),
                            SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                //minWidth: 20.0,
                                maxWidth: 300.0,
                                //minHeight: 20.0,
                                maxHeight: 100.0,
                              ),
                              child: AutoSizeText(
                                location,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.access_time),
                            SizedBox(width: 10),
                            ConstrainedBox(
                              constraints: BoxConstraints(
                                //minWidth: 20.0,
                                maxWidth: 300.0,
                                //minHeight: 20.0,
                                maxHeight: 100.0,
                              ),
                              child: AutoSizeText(
                                dateTime,
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  MultiBlocProvider commentPart(int event_id) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => CommunityEventCommentsBloc(),
        )
      ],
      child: CommunityEvenCommentsPage(
        event_id: event_id,
      ),
    );
  }

  deleteEvent(int event_id) async {
    await _databaseHelper.deleteEvent(event_id);
  }

  showDeleteConfirmationDialog(int event_id, CommunityEventsBloc bloc) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert!'),
          content: const Text('Are you sure?'),
          actions: <Widget>[
            //BuildAddEventButton(deleteEvent(event_id), 'Yes'),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  Future(() {
                    setState(() {
                      bloc.add(FetchCommunityEventsInfoEvent(
                          community_id: widget.community_id));
                      deleteEvent(event_id);
                    });
                  });
                  Navigator.pop(context, () {
                    setState(() {});
                  });
                });
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                setState(() {
                  Navigator.pop(context, () {
                    setState(() {});
                  });
                });
              },
            ),
          ],
        );
      },
    );
  }
}
