import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/bloc/event_bloc/bloc/event_bloc.dart';
import 'package:karo_app/ui/singlePages/SingleJoinedComEventPage.dart';
import 'package:karo_app/utils/database_helper.dart';

class SingleJoinedCommunityPage extends StatefulWidget {
  int comm_id;
  int user_id;

  SingleJoinedCommunityPage({@required this.comm_id, @required this.user_id})
      : assert(comm_id != null && user_id != null);

  @override
  _SingleJoinedCommunityPageState createState() =>
      _SingleJoinedCommunityPageState();
}

class _SingleJoinedCommunityPageState extends State<SingleJoinedCommunityPage> {
  bool joinState;
  DatabaseHelper _databaseHelper;
  String communityNameForTitle;
  Color buttonColor;
  bool showEventList;

  @override
  void initState() {
    super.initState();
    joinState = true;
    _databaseHelper = DatabaseHelper();
    communityNameForTitle = "Community name";
    buttonColor = Colors.red;
    showEventList = true;
  }

  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

    //check join state to display right
    Future(() async {
      FutureBuilder(
          future: checkUserCommJoinState(widget.user_id, widget.comm_id),
          builder: (context, mydata) {
            if (mydata.hasData) {
              joinState = mydata.data;

              if (joinState == true) {
                buttonColor = Colors.red;
              } else {
                buttonColor = Colors.green;
              }
            }
          });
    });

    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
            future: getCommunityName(widget.comm_id),
            builder: (context, myData) {
              if (myData.hasData) {
                communityNameForTitle = myData.data;
                return Text(myData.data);
              } else {
                return Text("Community name");
              }
            }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _communityBloc
              .add(FetchSingleJoinedCommunityEvent(comm_id: widget.comm_id));
        },
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: BlocBuilder(
              bloc: _communityBloc,
              builder: (context, CommunityState state) {
                //INITIAL STATE TO CALL EVENT
                if (state is CommunityInitial) {
                  _communityBloc.add(
                      FetchSingleJoinedCommunityEvent(comm_id: widget.comm_id));
                  return Center(child: CircularProgressIndicator());
                }

                //LOADING STATE TO LOAD DATA
                if (state is SingleCommunityLoadingState) {
                  return Center(child: CircularProgressIndicator());
                }

                //LOADED STATE - MAIN PART
                if (state is SingleCommunityLoadedState) {
                  return communityPage(state: state);
                }

                //ERROR STATE
                if (state is SingleCommunityLoadErrorState) {
                  return Center(
                    child: Text("ERROR"),
                  );
                }
              }),
        ),
      ),
    );
  }

  //COMMUNITY WHOLE PAGE
  Container communityPage({@required SingleCommunityLoadedState state}) {
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        children: <Widget>[
          //ilk basda pp ile isim , buton olacaq
          //-----------------------------------1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(
                      'https://globalactionplan.ie/wp-content/uploads/2016/08/Community-Icon.jpg'),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(8),
                        child: Center(
                          child: Text(
                            state.community.commName,
                            style: TextStyle(
                                fontFamily: "Roboto-Bold", fontSize: 20),
                          ),
                        )),
                    RaisedButton(
                        child: FutureBuilder(
                            future: checkUserCommJoinState(
                                widget.user_id, widget.comm_id),
                            builder: (context, mydata) {
                              if (mydata.hasData) {
                                joinState = mydata.data;

                                if (joinState == true) {
                                  showEventList = true;
                                  buttonColor = Colors.red;
                                }

                                return Text(joinState
                                    ? "Exit from community"
                                    : "Join to community");
                              } else {
                                return CircularProgressIndicator();
                              }
                            }),
                        color: buttonColor,
                        //color: buttonColor,

                        onPressed: () {
                          //CHECK THE JOIN STATE
                          if (joinState) {
                            //want exit from community

                            Future(() async {
                              //get state num from database_helper
                              int stateWithNum =
                                  await _databaseHelper.exitFromCommunity(
                                      widget.user_id, widget.comm_id);
                              //1-means no error while exitting
                              if (stateWithNum == 1) {
                                setState(() {
                                  joinState = !joinState;
                                  showEventList = false;
                                  buttonColor = Colors.green;

                                  print(
                                      "-USER-EXIT-${widget.comm_id}-COMMUNITY-");
                                });
                              }
                              //if there is some error
                              else {
                                print(
                                    "ERROR-USER-EXIT-${widget.comm_id}-COMMUNITY-");
                              }
                            });
                          } else if (!joinState) {
                            //want to get in community

                            Future(() async {
                              int stateWithNum =
                                  await _databaseHelper.joinCommunity(
                                      widget.user_id, widget.comm_id);

                              if (stateWithNum == 1) {
                                setState(() {
                                  joinState = !joinState;
                                  showEventList = true;
                                  buttonColor = Colors.redAccent;

                                  print(
                                      "-USER-JOINED-${widget.comm_id}-COMMUNITY-");
                                });
                              } else {
                                print(
                                    "-ERROR-USER-JOINED-${widget.comm_id}-COMMUNITY-");
                              }
                            });
                          }
                        })
                  ],
                ),
              )
            ],
          ),

          //desc-supervisor-date-created-
          //-----------------------------------2
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            //color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description : ${state.community.commDesc}",
                  style: TextStyle(fontSize: 18),
                ),
                Divider(
                  thickness: 1,
                ),
                Text(
                  "Supervisor : ${state.community.supervisor}",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Date created : ${state.community.dateCreated}",
                  style: TextStyle(fontSize: 15),
                ),
                Text(
                  state.community.contactInfo == null
                      ? ""
                      : "Contact info : ${state.community.contactInfo}",
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),

          Divider(),

          //EVENTS PART
          Container(
            width: 150,
            padding: EdgeInsets.only(top: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "Events",
                  style: TextStyle(fontFamily: "Roboto-Bold", fontSize: 20),
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
              ],
            ),
          ),

          //DURUMA UYGUN OLARAK LISTE CEKIP CEKEMEME
          FutureBuilder(
              future: checkUserCommJoinState(widget.user_id, widget.comm_id),
              builder: (context, myData) {
                if (myData.hasData) {
                  joinState = myData.data;

                  if (joinState) {
                    //BLOC UYGULANACAQ YER
                    var _eventBloc = BlocProvider.of<EventBloc>(context);

                    return BlocBuilder(
                        bloc: _eventBloc,
                        builder: (context, EventState state) {
                          //initial state
                          if (state is EventInitial) {
                            _eventBloc.add(FetchCommunityEventsEvent(
                                community_id: widget.comm_id));
                            print("initial state");
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          //loading state
                          if (state is AllEventsLoadingState) {
                            return Center(child: CircularProgressIndicator());
                          }

                          //load state - main state
                          if (state is AllEventsLoadedState) {
                            var list = state.event_list;

                            if (list.length == 0) {
                              return RichText(
                                  text: TextSpan(
                                style: TextStyle(color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: communityNameForTitle,
                                      style: TextStyle(
                                          color: Colors.red,
                                          decoration:
                                              TextDecoration.underline)),
                                  TextSpan(
                                    text: "   does not have any event, yet.",
                                    style: TextStyle(color: Colors.black),
                                  )
                                ],
                              ));
                            } else {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.event_list.length,
                                    itemBuilder: (context, index) {
                                      return card(
                                          context: context,
                                          eventID: list[index].eventID,
                                          eventName: list[index].eventTitle,
                                          datetime: list[index].eventDateTime,
                                          place: list[index].eventLocation,
                                          desc: list[index].eventDesc);
                                    }),
                              );
                            }
                          }

                          //load error state
                          if (state is AllEventsLoadErrorState) {
                            print("error happened");
                            return Center(
                              child: Text("ERROR"),
                            );
                          }
                        });
                  } else {
                    return RichText(
                        text: TextSpan(
                      text: "First Join   ",
                      style: TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                            text: communityNameForTitle,
                            style: TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.underline)),
                        TextSpan(
                          text: "   to see the events.",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ));

                    //Text("First Join ${communityNameForTitle} to see the events.");

                  }
                } else {
                  return CircularProgressIndicator();
                }
              }),
          //LISTVIEW
        ],
      ),
    );
  }

  //event part - ui
  Container card(
      {@required BuildContext context,
      @required int eventID,
      @required String eventName,
      @required String datetime,
      @required String place,
      @required String desc}) {
    return Container(
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
                //event page-e gidicek
                Future(() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MultiBlocProvider(
                              providers: [
                                BlocProvider(
                                    create: (BuildContext context) =>
                                        CommentBloc()),
                                BlocProvider<EventBloc>(
                                    create: (BuildContext context) =>
                                        EventBloc())
                              ],
                              child: SingleJoinedComEventPage(
                                  user_id: widget.user_id,
                                  event_id: eventID))));
                });
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    flex: 5,
                    child: Text(
                      eventName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          datetime,
                          style: TextStyle(fontSize: 13),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.place),
                            Text(
                              place,
                              style: TextStyle(fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              //DESCRIPTION PART
              subtitle: Container(
                padding: EdgeInsets.only(top: 15, bottom: 20),
                child: Text(
                  desc,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: TextStyle(fontSize: 15),
                ),
              )),
        ),
      ),
    );
  }

  // get community name with using community id
  Future<String> getCommunityName(int comm_id) async {
    String community_name =
        await _databaseHelper.getCommunityNameWithID(comm_id);

    print("b");

    return community_name;
  }

  Future<bool> checkUserCommJoinState(int user_id, int comm_id) async {
    int a = await _databaseHelper.checkUserCommunityJoinState(user_id, comm_id);

    print("a");

    if (a == 0) {
      buttonColor = Colors.green;
      return false;
    } else {
      buttonColor = Colors.red;
      return true;
    }
  }
}
