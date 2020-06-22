import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';

class AllJoinedEventListPage extends StatefulWidget {
  int user_id;

  AllJoinedEventListPage({@required this.user_id}) : assert(user_id != null);

  @override
  _AllJoinedEventListPageState createState() => _AllJoinedEventListPageState();
}

class _AllJoinedEventListPageState extends State<AllJoinedEventListPage> {
  @override
  Widget build(BuildContext context) {
    final _eventBloc = BlocProvider.of<EventBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Joined Events"),
      ),
      body: BlocBuilder(
          bloc: _eventBloc,
          builder: (context, EventState state) {
            //INITIAL STATE TO CALL AN EVENT
            if (state is EventInitial) {
              _eventBloc.add(FetchAllJoinedEvent(user_id: widget.user_id));
              return Center(child: CircularProgressIndicator());
            }

            //LOADING STATE
            if (state is AllEventsLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            //LOADED - MAIN STATE
            if (state is AllEventsLoadedState) {
              return ListView.builder(
                  itemCount: state.event_list.length,
                  itemBuilder: (context, index) {
                    return cardEvent(
                        event_id: state.event_list[index].eventID,
                        event_name: state.event_list[index].eventTitle,
                        community_name: state.event_list[index].community_name,
                        datetime: state.event_list[index].eventDateTime,
                        place: state.event_list[index].eventLocation,
                        desc: state.event_list[index].eventDesc);
                  });
            }

            //LOAD ERROR STATE
            if (state is AllEventsLoadErrorState) {
              return Center(
                child: Text("ERROR"),
              );
            }
          }),
    );
  }

  Container cardEvent(
      {@required int event_id,
      @required String event_name,
      @required String community_name,
      @required String datetime,
      @required String place,
      @required String desc}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Card(
        elevation: 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            onTap: () {
              print(event_id);
            },

            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // EVENT NAME & COMMUNITY NAME
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(event_name),
                    SizedBox(height: 5),
                    Text(
                      community_name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                //EVENT DATETIME & EVENT PLACE
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

            //SUB TITLE FOR DESCRIBTION
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
