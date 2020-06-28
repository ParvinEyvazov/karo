import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
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
              backgroundColor: Colors.blueGrey.shade400,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  "Welcome $name!",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Pacifico",
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
                      return ListView.builder(
                          itemCount: state.event_list.length,
                          itemBuilder: (context, index) {
                            return card(
                                context: context,
                                eventID: state.event_list[index].eventID,
                                eventName: state.event_list[index].eventTitle,
                                communityName:
                                    state.event_list[index].community_name,
                                datetime: state.event_list[index].eventDateTime,
                                place: state.event_list[index].eventLocation,
                                desc: state.event_list[index].eventDesc);
                          });
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
                              BlocProvider<EventBloc>(
                                  create: (BuildContext context) => EventBloc())
                            ],
                            child:
                                SingleJoinedComEventPage(event_id: eventID))));
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
}
