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

  @override
  void initState() {
    super.initState();
    joinState = false;
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

    // Future(() async {

    //     joinState = checkUserCommJoinState(widget.user_id, widget.comm_id);

    // });

    return Scaffold(
      appBar: AppBar(
        title: Text("Non Joined Community"),
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
              return Container(
                padding: EdgeInsets.only(top: 35, left: 35, right: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      state.community.commName,
                      style: TextStyle(fontSize: 35),
                    ),
                    SizedBox(height: 35),
                    Text(
                      state.community.commDesc,
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 35),
                    Center(
                        child: RaisedButton(
                            child: FutureBuilder(
                                future: checkUserCommJoinState(
                                    widget.user_id, widget.comm_id),
                                builder: (context, mydata){

                                  if(mydata.hasData){

                                    joinState = mydata.data;

                                    return Text(joinState ? "Joined" : "Join Us"); 
                                  }else{
                                    return CircularProgressIndicator();
                                  }


                                }),
                            onPressed: () {
                              //CHECK THE JOIN STATE
                              if (joinState) {
                                //want exit from community
                                setState(() {
                                  print(
                                      "${widget.user_id} com:${widget.comm_id} -dan cixmaq istiyir");
                                  joinState = !joinState;

                                  Future(() async {
                                    _databaseHelper.exitFromCommunity(
                                        widget.user_id, widget.comm_id);
                                  });

                                  print("cixdi(turkun mesel)");
                                });
                              } else if (!joinState) {
                                //want to get in community
                                setState(() {
                                  print(
                                      "${widget.user_id} com:${widget.comm_id} -a girmek istiyir.");
                                  joinState = !joinState;

                                  Future(() async {
                                    await _databaseHelper.joinCommunity(
                                        widget.user_id, widget.comm_id);
                                  });

                                  print("girdi(turkun mesel)");
                                });
                              }
                            }))
                  ],
                ),
              );
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
