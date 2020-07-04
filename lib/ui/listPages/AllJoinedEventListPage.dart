import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_event_list_tile.dart';
import 'package:karo_app/ui/singlePages/SingleJoinedEventPage.dart';

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
        backgroundColor: Color(0XFF306cbd),
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
              return Stack(
                children: <Widget>[
                  BuildBackgroundBottomCircle(Colors.blue),
                  RefreshIndicator(
                    onRefresh: () async {
                      _eventBloc
                          .add(FetchAllJoinedEvent(user_id: widget.user_id));
                    },
                    child: ListView.builder(
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
                        }),
                  ),
                ],
              );
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
                          child: SingleJoinedEventPage(
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
  // Container cardEvent(
  //     {@required BuildContext context,
  //     @required int eventID,
  //     @required String eventName,
  //     @required String communityName,
  //     @required String datetime,
  //     @required String place,
  //     @required String desc}) {
  //   return Container(
  //     color: Colors.blueGrey.shade400,
  //     padding: EdgeInsets.all(8),
  //     child: Card(
  //       elevation: 5,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.all(
  //             Radius.circular(10),
  //           ),
  //         ),
  //         child: ListTile(
  //           onTap: () {
  //             //going to single event page
  //             Future(() {
  //               Navigator.of(context).push(MaterialPageRoute(
  //                   builder: (context) => MultiBlocProvider(
  //                           providers: [
  //                             BlocProvider(
  //                                 create: (BuildContext context) =>
  //                                     CommentBloc()),
  //                             BlocProvider<EventBloc>(
  //                                 create: (BuildContext context) => EventBloc())
  //                           ],
  //                           child: SingleJoinedEventPage(
  //                               user_id: widget.user_id, event_id: eventID))));
  //             });
  //           },
  //           //Title part
  //           //include -> ROW(column1(event name , community) , column2(datatime, place))
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               // EVENT NAME & COMMUNITY NAME
  //               Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: <Widget>[
  //                   Text(
  //                     eventName,
  //                     style:
  //                         TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(height: 5),
  //                   Text(
  //                     communityName,
  //                     overflow: TextOverflow.ellipsis,
  //                     style: TextStyle(fontSize: 13),
  //                   )
  //                 ],
  //               ),
  //               Expanded(
  //                 child: Container(
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.end,
  //                     children: <Widget>[
  //                       Text(
  //                         datetime,
  //                         maxLines: 1,
  //                         style: TextStyle(fontSize: 13),
  //                       ),
  //                       SizedBox(height: 5),
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.end,
  //                         children: <Widget>[
  //                           Icon(Icons.place),
  //                           Flexible(
  //                             child: Text(
  //                               place,
  //                               style: TextStyle(fontSize: 13),
  //                               overflow: TextOverflow.ellipsis,
  //                             ),
  //                           )
  //                         ],
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),

  //           subtitle: Container(
  //             padding: EdgeInsets.only(top: 15, bottom: 20),
  //             child: Text(
  //               desc,
  //               overflow: TextOverflow.ellipsis,
  //               maxLines: 1,
  //               style: TextStyle(fontSize: 15),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
