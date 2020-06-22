import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/ui/singlePages/SingleJoinedComEventPage.dart';

class TimelinePage extends StatelessWidget {
  int user_id;

  TimelinePage({this.user_id});

  @override
  Widget build(BuildContext context) {
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome Parvin !",
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
              _eventBloc.add(FetchAllJoinedComEventsEvent(user_id: user_id));
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
                        communityName: state.event_list[index].community_name,
                        datetime: state.event_list[index].eventDateTime,
                        place: state.event_list[index].eventLocation,
                        desc: state.event_list[index].eventDesc);
                  });

              // return Column(
              //   children: <Widget>[
              //     Container(
              //       color: Colors.blueGrey.shade400,
              //       padding: EdgeInsets.only(left: 22.0, top: 40.0, bottom: 35.0),
              //       child: Text(
              //         "Welcome, Parvin!",
              //         style: TextStyle(
              //           fontSize: 46,
              //           fontFamily: "Pacifico",
              //         ),
              //       ),
              //     ),
              //     Divider(
              //       color: Colors.black,
              //       thickness: 2.0,
              //       height: 2.0,
              //     ),
            }

            if (state is AllEventsLoadErrorState) {
              return Center(child: Text("ERROR"));
            }

            //return Text("data");
          }),
    );
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
        elevation: 4,
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
                    Text(eventName),
                    SizedBox(height: 5),
                    Text(
                      communityName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(datetime),
                    SizedBox(height: 5),
                    Row(
                      children: <Widget>[
                        Icon(Icons.place),
                        Text(place),
                      ],
                    )
                  ],
                ),
              ],
            ),

            subtitle: Container(
              padding: EdgeInsets.only(top: 15, bottom: 20),
              child: Text(
                desc,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
