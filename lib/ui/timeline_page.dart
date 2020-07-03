import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_event_list_tile.dart';
import 'package:karo_app/ui/singlePages/SingleJoinedComEventPage.dart';
import 'package:karo_app/utils/database_helper.dart';

class TimelinePage extends StatefulWidget {
  int user_id;

  TimelinePage({this.user_id});

  @override
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  DatabaseHelper _databaseHelper;

  String name = "NAME";

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    //name =  _databaseHelper.getUserName(widget.user_id);

    return FutureBuilder(
        future: getUserName(widget.user_id),
        builder: (context, datam) {
          if (datam.hasData) {
            //get data
            name = datam.data;

            return Scaffold(
              //backgroundColor: Colors.blueGrey.shade400,
              appBar: AppBar(
                backgroundColor: Color(0XFF306cbd),
                automaticallyImplyLeading: false,
                title: Text(
                  "Welcome $name!",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Baslik",
                  ),
                ),
              ),
              body: BlocBuilder(
                  bloc: _eventBloc,
                  builder: (context, EventState state) {
                    //INITIAL STATE
                    if (state is EventInitial) {
                      _eventBloc.add(FetchAllJoinedComEventsEvent(
                          user_id: widget.user_id));
                      return Center(child: CircularProgressIndicator());
                    }

                    //LOADING STATE
                    if (state is AllEventsLoadingState) {
                      return Center(child: CircularProgressIndicator());
                    }

                    //LOADED STATE --MAIN PART
                    if (state is AllEventsLoadedState) {
                      return Stack(
                        children: <Widget>[
                          BuildBackgroundBottomCircle(Colors.blue),
                          RefreshIndicator(
                            onRefresh: () async {
                              _eventBloc.add(FetchAllJoinedComEventsEvent(
                                  user_id: widget.user_id));
                            },
                            child: ListView.builder(
                                itemCount: state.event_list.length,
                                itemBuilder: (context, index) {
                                  return card(
                                      context: context,
                                      eventID: state.event_list[index].eventID,
                                      eventName:
                                          state.event_list[index].eventTitle,
                                      communityName: state
                                          .event_list[index].community_name,
                                      datetime:
                                          state.event_list[index].eventDateTime,
                                      place:
                                          state.event_list[index].eventLocation,
                                      desc: state.event_list[index].eventDesc);
                                }),
                          ),
                        ],
                      );
                    }

                    if (state is AllEventsLoadErrorState) {
                      return Center(child: Text("ERROR"));
                    }

                    //return Text("data");
                  }),
            );
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  //get name method
  Future<String> getUserName(int user_id) async {
    String name = await _databaseHelper.getUserName(user_id);

    return name;
  }

  Container card(
      {@required BuildContext context,
      @required int eventID,
      @required String eventName,
      @required String communityName,
      @required String datetime,
      @required String place,
      @required String desc}) {
    return Container(
      //color: Colors.blueGrey.shade400,
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 10,
        shadowColor: Colors.blue[900],
        child: BuildEventListTile(
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
                          child: SingleJoinedComEventPage(
                              user_id: widget.user_id, event_id: eventID))));
            });
          },
          address: place,
          communityName: communityName,
          datetime: datetime,
          description: desc,
          eventName: eventName,
        ),
      ),
    );
  }
}
