import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/utils/database_helper.dart';

class SingleNonJoinedCommunityPage extends StatefulWidget {
  int comm_id;
  int user_id;

  SingleNonJoinedCommunityPage({@required this.comm_id, @required this.user_id})
      : assert(comm_id != null && user_id != null);

  @override
  _SingleNonJoinedCommunityPageState createState() =>
      _SingleNonJoinedCommunityPageState();
}

class _SingleNonJoinedCommunityPageState
    extends State<SingleNonJoinedCommunityPage> {
  bool joinState;
  DatabaseHelper _databaseHelper;
  String communityNameForTitle;
  Color buttonColor;
  bool showEventList;

  @override
  void initState() {
    super.initState();
    joinState = false;
    _databaseHelper = DatabaseHelper();
    communityNameForTitle = "Community name";
    buttonColor = Colors.green;
    showEventList = false;
  }

  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

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
      body: SingleChildScrollView(
        child: BlocBuilder(
          bloc: _communityBloc,
          builder: (context, CommunityState state) {
            //Initial State
            if (state is CommunityInitial) {
              _communityBloc.add(
                  FetchSingleNonJoinedCommunityEvent(comm_id: widget.comm_id));
              return Center(child: CircularProgressIndicator());
            }

            // Loading state
            if (state is SingleCommunityLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            //LOADED STATE - MAIN PART
            if (state is SingleCommunityLoadedState) {
              return communityPage(state: state);
            }

            //ERROR STATE
            if (state is SingleCommunityLoadErrorState) {
              return Center(child: Text("ERROR 404"));
            }
          },
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
                            setState(() {
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
                                  });
                                  print(
                                      "-USER-EXIT-${widget.comm_id}-COMMUNITY-");
                                }
                                //if there is some error
                                else {
                                  print(
                                      "ERROR-USER-EXIT-${widget.comm_id}-COMMUNITY-");
                                }
                              });
                            });
                          } else if (!joinState) {
                            //want to get in community
                            setState(() {
                              Future(() async {
                                int stateWithNum =
                                    await _databaseHelper.joinCommunity(
                                        widget.user_id, widget.comm_id);

                                if (stateWithNum == 1) {
                                  setState(() {
                                    joinState = !joinState;
                                    showEventList = true;
                                    buttonColor = Colors.redAccent;
                                  });
                                  print(
                                      "-USER-JOINED-${widget.comm_id}-COMMUNITY-");
                                } else {
                                  print(
                                      "-ERROR-USER-JOINED-${widget.comm_id}-COMMUNITY-");
                                }
                              });
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
                  "Describtion : ${state.community.commDesc}",
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
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return Text("BURADA EVENTLER OLUCAK");
                          }),
                    );
                  } else {
/*
RichText(
  text: TextSpan(
    text: "Don't tax the South ",
    children: <TextSpan>[
      TextSpan(
        text: 'cuz',
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.underline,
          decorationColor: Colors.red,
          decorationStyle: TextDecorationStyle.wavy,
        ),
      ),
      TextSpan(
        text: ' we got it made in the shade',
      ),
    ],
  ),
)
 */

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

  // get community name with using community id
  Future<String> getCommunityName(int comm_id) async {
    String community_name =
        await _databaseHelper.getCommunityNameWithID(comm_id);

    return community_name;
  }

  //checker for join button
  Future<bool> checkUserCommJoinState(int user_id, int comm_id) async {
    int a = await _databaseHelper.checkUserCommunityJoinState(user_id, comm_id);

    if (a == 0) {
      return false;
    } else {
      return true;
    }
  }
}
