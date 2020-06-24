import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';

class SingleJoinedEventPage extends StatefulWidget {
  int event_id;

  SingleJoinedEventPage({@required this.event_id}) : assert(event_id != null);

  @override
  _SingleJoinedEventPageState createState() => _SingleJoinedEventPageState();
}

class _SingleJoinedEventPageState extends State<SingleJoinedEventPage> {
  @override
  Widget build(BuildContext context) {
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Joined event"),
      ),
      body: BlocBuilder(
          bloc: _eventBloc,
          builder: (context, EventState state) {
            //initial state to call  an event
            if (state is EventInitial) {
              _eventBloc.add(FetchSingleJoinedEvent(event_id: widget.event_id));
              return Center(child: CircularProgressIndicator());
            }

            //LOADING STATE to laod the data
            if (state is SingleEventLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            //LOAD STATE
            if (state is SingleEventLoadedState) {
              return Container(
                padding: EdgeInsets.only(top: 35, left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.event.eventTitle,
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(height: 25),
                    Text(
                      state.event.community_name,
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.date_range),
                            Text(state.event.eventDateTime)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.place),
                            Text(state.event.eventLocation)
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      state.event.eventDesc,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            }

            if (state is SingleEventLoadErrorState) {
              return Center(
                child: Text("ERROR"),
              );
            }
          }),
    );
  }
}
