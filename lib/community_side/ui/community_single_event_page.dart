import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/components/build_avatar_container.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/models/event.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunitySingleEventPage extends StatefulWidget {
  int event_id;
  CommunitySingleEventPage({this.event_id});
  @override
  _CommunitySingleEventPageState createState() =>
      _CommunitySingleEventPageState();
}

class _CommunitySingleEventPageState extends State<CommunitySingleEventPage> {
  final blueColor = Color(0XFF5e92f3);

  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _eventBloc,
        builder: (context, EventState state) {
          if (state is EventInitial) {
            _eventBloc.add(FetchSingleEvent(widget.event_id));
            return Center(child: CircularProgressIndicator());
          }

          if (state is SingleEventLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is SingleEventLoadedState) {
            return Stack(
              children: <Widget>[
                BuildTopCircle(offSetValue: 1.3),
                BuildBackgroundBottomCircle(Colors.blue),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.37,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "EVENT",
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
                      middlePart(
                          context: context,
                          title: state.event.eventTitle,
                          description: state.event.eventDesc,
                          dateTime: state.event.eventDateTime,
                          location: state.event.eventLocation,
                          quota: state.event.quota,
                          joinedUser: 0,
                          event_id: widget.event_id,
                          event: state.event)
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
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
    return Row(children: <Widget>[
      Expanded(
        child: Column(children: <Widget>[
//--------------TITLE AND QUOTA-----------
          Container(
            //height: 400,
            margin: EdgeInsets.only(left: 20, right: 20),
            padding: EdgeInsets.all(20),
            decoration: CustomBoxDecoration().create(blueColor, 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Flexible(
                //   child: editButton(event),
                // ),
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
          )
        ]),
      ),
    ]);
  }
}
