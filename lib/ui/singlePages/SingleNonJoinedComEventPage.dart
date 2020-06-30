import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/ui/singlePages/SingleNonJoinedCommunityPage.dart';
import 'package:karo_app/utils/database_helper.dart';

class SingleNonJoinedComEventPage extends StatefulWidget {
  int event_id;
  int user_id;

  SingleNonJoinedComEventPage({@required this.event_id, @required this.user_id})
      : assert(event_id != null && user_id != null);

  @override
  _SingleNonJoinedComEventPageState createState() =>
      _SingleNonJoinedComEventPageState();
}

class _SingleNonJoinedComEventPageState
    extends State<SingleNonJoinedComEventPage> {
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    // initialize the event bloc
    final _eventBloc = BlocProvider.of<EventBloc>(context);
    final _commentBloc = BlocProvider.of<CommentBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            future: getEventName(widget.event_id),
            builder: (context, mydata) {
              if (mydata.hasData) {
                return Text(mydata.data);
              } else {
                return Text("Event");
              }
            }),
        backgroundColor: Color(0xffb321307),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _eventBloc.add(
                FetchSingleNonJoinedComEventEvent(event_id: widget.event_id));
          });
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder(
              bloc: _eventBloc,
              builder: (context, EventState state) {
                ////////////////////////////////////////////////////////////////////////////-INITIAL
                if (state is EventInitial) {
                  _eventBloc.add(FetchSingleNonJoinedComEventEvent(
                      event_id: widget.event_id));
                  return Center(child: CircularProgressIndicator());
                }

                if (state is SingleEventLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                if (state is SingleEventLoadedState) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: Image.asset("assets/photos/event.jpg"),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 15, left: 35, right: 35),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              state.event.eventTitle,
                              style: TextStyle(fontSize: 30),
                            ),
                            SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    state.event.community_name,
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 15),
                                FutureBuilder(
                                    future: getCommunityIdWithEventId(
                                        widget.event_id),
                                    builder: (context, mydata) {
                                      if (mydata.hasData) {
                                        int comm_id = mydata.data;
                                        return RaisedButton(
                                          color: Colors.black,
                                          child: Text(
                                            "Join this Community",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () {
                                            //GO TO THIS COMMUNITY PAGE
                                            Future(() {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          MultiBlocProvider(
                                                              providers: [
                                                                BlocProvider(
                                                                    create: (BuildContext
                                                                            context) =>
                                                                        CommunityBloc()),
                                                                BlocProvider(
                                                                    create: (BuildContext
                                                                            context) =>
                                                                        EventBloc()),
                                                              ],
                                                              child: SingleNonJoinedCommunityPage(
                                                                  comm_id:
                                                                      comm_id,
                                                                  user_id: widget
                                                                      .user_id))));
                                            });
                                          },
                                        );
                                      } else {
                                        return RaisedButton(
                                          child: Text("Join this Community"),
                                          onPressed: () {},
                                        );
                                      }
                                    }),
                              ],
                            ),
                            SizedBox(height: 25),
                            Text(
                              state.event.eventDesc,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 25),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.date_range),
                                    Text(state.event.eventDateTime)
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(Icons.place),
                                    Text(state.event.eventLocation)
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Divider(
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      //COMMENT
                      Container(
                        width: MediaQuery.of(context).size.width * 1 / 3,
                        padding: EdgeInsets.only(top: 15),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              "Comments",
                              style: TextStyle(
                                  fontFamily: "Roboto-Bold", fontSize: 20),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),

                      //FUTURE FUNCTION FOR COMMENTS
                      BlocBuilder(
                          bloc: _commentBloc,
                          builder: (context, CommentState state) {
                            //initial state
                            if (state is CommentInitial) {
                              _commentBloc.add(FetchAllEventCommentsEvent(
                                  event_id: widget.event_id));
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            //loading state
                            if (state is AllCommentsLoadingState) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            //loaded state -main state
                            if (state is AllCommentsLoadedState) {
                              var list = state.comment_list;

                              if (list.length == 0) {
                                return Text("There is not any comment, yet.");
                              } else {
                                return Container(
                                  child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: list.length,
                                      itemBuilder: (context, index) {
                                        return commentCard(
                                            context,
                                            list[index].userId,
                                            list[index].userName,
                                            list[index].userSurname,
                                            list[index].eventId,
                                            list[index].dateTime,
                                            list[index].text,
                                            list[index].deleted);
                                      }),
                                );
                              }
                            }

                            //error state
                            if (state is AllCommentsLoadErrorState) {
                              return Center(
                                child: Text("Error while loading comments"),
                              );
                            }
                          }),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }

/*
  int commentId;
  int userId;
  String userName;
  String userSurname;
  int eventId;
  String dateTime;
  String text;
  int deleted;
 */
  Container commentCard(
    @required BuildContext context,
    @required int userId,
    @required String userName,
    @required String userSurname,
    @required int eventId,
    @required String dateTime,
    @required String text,
    @required int deleted,
  ) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.symmetric(horizontal: 35),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "${userName} ${userSurname}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(dateTime),
            ],
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(text),
          ),
          Divider(
            color: Colors.black,
          )
        ],
      ),
    );
  }

  Future<int> getCommunityIdWithEventId(int event_id) async {
    int comm_id;
    //int comm_id = 2;
    comm_id = await _databaseHelper.getCommunityIdWithEventID(event_id);

    return comm_id;
  }

  Future<String> getEventName(int event_id) async {
    String event_title;

    event_title = await _databaseHelper.getEventNameWithEventID(event_id);

    return event_title;
  }
}
