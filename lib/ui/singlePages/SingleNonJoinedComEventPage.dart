import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';

class SingleNonJoinedComEventPage extends StatefulWidget {
  int event_id;

  SingleNonJoinedComEventPage({@required this.event_id})
      : assert(event_id != null);

  @override
  _SingleNonJoinedComEventPageState createState() =>
      _SingleNonJoinedComEventPageState();
}

class _SingleNonJoinedComEventPageState
    extends State<SingleNonJoinedComEventPage> {
  @override
  Widget build(BuildContext context) {
    // initialize the event bloc
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Event of nonjoined community"),
      ),
      body: SingleChildScrollView(
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              state.event.community_name,
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                          SizedBox(width: 15),
                          RaisedButton(
                            child: Text("Join this Community"),
                            onPressed: () {},
                          ),
                        ],
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
            }),
      ),
    );
  }
}
