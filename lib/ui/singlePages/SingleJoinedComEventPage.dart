import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';

class SingleJoinedComEventPage extends StatefulWidget {
  int event_id;

  SingleJoinedComEventPage({@required this.event_id})
      : assert(event_id != null);

  @override
  _SingleJoinedComEventPageState createState() =>
      _SingleJoinedComEventPageState();
}

class _SingleJoinedComEventPageState extends State<SingleJoinedComEventPage> {
  @override
  Widget build(BuildContext context) {
    //initialize BLOC
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Single Event Appbar"),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder(
          bloc: _eventBloc,
          builder: (context, EventState state) {
            ////////////////////////////////////////////////////////////////////////////-INITIAL
            if (state is EventInitial) {
              _eventBloc.add(
                  FetchSingleJoinedComEventEvent(event_id: widget.event_id));
              return Center(child: CircularProgressIndicator());
            }

            ////////////////////////////////////////////////////////////////////////////-LOADING
            if (state is SingleEventLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            ////////////////////////////////////////////////////////////////////////////-LOADED
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
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(Icons.done),
                                onPressed: () {},
                              ),
                              IconButton(
                                  icon: Icon(Icons.nature_people),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.clear), onPressed: () {}),
                            ],
                          ),
                        )
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
                        )
                      ],
                    ),
                    SizedBox(height: 25),
                    Text(
                      state.event.eventDesc,
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              );
            }

            ////////////////////////////////////////////////////////////////////////////-ERROR
            if (state is SingleEventLoadErrorState) {
              return Center(
                child: Text(
                  "HATA",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            ////////////////////////////////////////////////////////////////////////////-END
          },
        ),
      ),
    );
  }
}

/*
Container(
            padding: EdgeInsets.only(top: 35, left: 35, right: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "EVENT A",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Community Y",
                      style: TextStyle(fontSize: 30),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.done) ,onPressed: (){},),
                          IconButton(icon: Icon(Icons.nature_people), onPressed: (){}),
                          IconButton(icon: Icon(Icons.clear), onPressed: (){}),                        
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.date_range),
                        Text("27.07.1999")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.place),
                        Text("Meltem Ust Gecit")
                      ],
                    )
                  ],
                ),
                SizedBox(height: 25),
                Text(
                  "Event Description",
                  style: TextStyle(fontSize: 18),
                )
              ],
            ),
          ),
 */
