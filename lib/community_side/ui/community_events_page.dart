import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/components/banner_clipper.dart';
import 'package:karo_app/community_side/components/build_background_bottom_circle.dart';
import 'package:karo_app/community_side/components/build_top_circle.dart';

class CommunityEventsPage extends StatefulWidget {
  int community_id;
  CommunityEventsPage({this.community_id});

  @override
  _CommunityEventsPageState createState() => _CommunityEventsPageState();
}

class _CommunityEventsPageState extends State<CommunityEventsPage> {
  int defaultListItemIndex = 0;
  final blueColor = Color(0XFF5e92f3);

  bool editModeActive = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _communityEventsBloc = BlocProvider.of<CommunityEventsBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder(
        bloc: _communityEventsBloc,
        builder: (context, CommunityEventsState state) {
          if (state is CommunityEventsInitial) {
            _communityEventsBloc.add(FetchCommunityEventsInfoEvent(
                community_id: widget.community_id));
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommunityEventsLoadingState) {
            return Center(child: CircularProgressIndicator());
          }

          if (state is CommunityEventsLoadedState) {
            return Stack(
              children: <Widget>[
                BuildTopCircle(),
                BuildBackgroundBottomCircle(blueColor),
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      // Column(
                      //   children: <Widget>[
                      //     // ClipPath(
                      //     //   clipper: BannerClipper(),
                      //     //   child: Container(
                      //     //     height: 250,
                      //     //     width: double.infinity,
                      //     //     decoration: BoxDecoration(
                      //     //         gradient: LinearGradient(
                      //     //             begin: Alignment.topRight,
                      //     //             end: Alignment.bottomLeft,
                      //     //             colors: [
                      //     //           Color(0xFF3383CD),
                      //     //           Color(0xFF11249F),
                      //     //         ])),
                      //     //     child: Row(
                      //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     //       children: <Widget>[
                      //     //         //EVENT TITLE
                      //     //         Container(
                      //     //             padding: EdgeInsets.only(top: 60, left: 30),
                      //     //             alignment: Alignment.topLeft,
                      //     //             child: Text(
                      //     //               state.events[defaultListItemIndex]
                      //     //                   .eventTitle,
                      //     //               style: TextStyle(
                      //     //                   color: Colors.white, fontSize: 30),
                      //     //             )),

                      //     //         Column(
                      //     //           children: <Widget>[
                      //     //             //EDIT BUTTON
                      //     //             Container(
                      //     //               margin:
                      //     //                   EdgeInsets.only(top: 40, right: 20),
                      //     //               decoration: BoxDecoration(
                      //     //                   color: Colors.white,
                      //     //                   borderRadius: BorderRadius.all(
                      //     //                       Radius.circular(50))),
                      //     //               child: IconButton(
                      //     //                 icon: Icon(Icons.edit),
                      //     //                 onPressed: () {
                      //     //                   setState(() {
                      //     //                     editModeActive = !editModeActive;
                      //     //                   });
                      //     //                 },
                      //     //               ),
                      //     //             ),
                      //     //             //EVENT QUOTA
                      //     //             Container(
                      //     //               margin:
                      //     //                   EdgeInsets.only(top: 50, right: 20),
                      //     //               child: Text(
                      //     //                   "${state.numbers[defaultListItemIndex].toString()}/${state.events[defaultListItemIndex].quota}",
                      //     //                   style: TextStyle(
                      //     //                       fontSize: 20,
                      //     //                       color: Colors.white,
                      //     //                       fontWeight: FontWeight.bold)),
                      //     //             ),
                      //     //           ],
                      //     //         ),
                      //     //       ],
                      //     //     ),
                      //     //   ),
                      //     // ),
                      //     editModeActive == true
                      //         ? descAndDateEdit()
                      //         : descAndDate(
                      //             description: state
                      //                 .events[defaultListItemIndex].eventDesc,
                      //             dateTime: state.events[defaultListItemIndex]
                      //                 .eventDateTime),

                      //     //SAVE BUTTON
                      //     editModeActive == true
                      //         ? Container(
                      //             alignment: Alignment.bottomRight,
                      //             padding: EdgeInsets.only(top: 20, right: 20),
                      //             child: FlatButton(
                      //               color: Color(0xFF3383CD),
                      //               textColor: Colors.white,
                      //               disabledColor: Colors.grey,
                      //               disabledTextColor: Colors.black,
                      //               padding: EdgeInsets.all(8.0),
                      //               splashColor: Colors.blueAccent,
                      //               onPressed: () {
                      //                 /*...*/
                      //               },
                      //               child: Text(
                      //                 "Save",
                      //                 style: TextStyle(fontSize: 20.0),
                      //               ),
                      //             ),
                      //           )
                      //         : Container()
                      //   ],
                      // ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.events.length,
                                itemBuilder: (context, index) {
                                  return eventCard(
                                      context: context,
                                      eventName: state.events[index].eventTitle,
                                      communityName:
                                          state.events[index].community_name,
                                      tileIndex: index);
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          if (state is CommunityEventsLoadErrorState) {
            return Center(child: Text("ERROR"));
          }
        },
      ),
    );
  }

  GestureDetector eventCard(
      {@required BuildContext context,
      @required String eventName,
      @required String communityName,
      @required int tileIndex}) {
    return GestureDetector(
      onLongPress: () {},
      child: Container(
        padding: EdgeInsets.all(8),
        child: Container(
            decoration: BoxDecoration(
              color: defaultListItemIndex != null &&
                      defaultListItemIndex == tileIndex
                  ? Colors.grey
                  : Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            child: ListTile(
                onTap: () {
                  setState(() {
                    defaultListItemIndex = tileIndex;
                  });
                },
                //Title part
                //include -> ROW(column1(event name , community) , column2(datatime, place))
                title: Text(
                  eventName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ))),
      ),
    );
  }
}

Row descAndDate({
  @required String description,
  @required String dateTime,
}) {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: 200,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //EVENT DESCRIPTION
              Text(
                description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              //EVENT DATE TIME
              Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    dateTime,
                    style: TextStyle(fontSize: 18),
                  ))
            ],
          ),
        ),
      )
    ],
  );
}

Row descAndDateEdit() {
  return Row(
    children: <Widget>[
      Expanded(
        child: Container(
          height: 200,
          margin: EdgeInsets.only(left: 20, right: 20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //EVENT DESCRIPTION
              Expanded(
                child: Container(
                  child: TextField(
                    onChanged: (text) {},
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description',
                    ),
                  ),
                ),
              ),
              //EVENT DATE TIME
              Text("ASFAFSFASFA")
            ],
          ),
        ),
      )
    ],
  );
}
