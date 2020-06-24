import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';

class SingleNonJoinedCommunityPage extends StatefulWidget {
  int comm_id;

  SingleNonJoinedCommunityPage({@required this.comm_id})
      : assert(comm_id != null);

  @override
  _SingleNonJoinedCommunityPageState createState() =>
      _SingleNonJoinedCommunityPageState();
}

class _SingleNonJoinedCommunityPageState
    extends State<SingleNonJoinedCommunityPage> {
  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

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
                            child: Text("Join US!"), onPressed: () {}))
                  ],
                ),
              );
            }


            //ERROR STATE
            if(state is SingleCommunityLoadErrorState){
              return Center(child: Text("ERROR 404"));
            }


          },
        ),
      ),
    );
  }
}

/*
Container(
            padding: EdgeInsets.only(top: 35, left: 35, right: 35),
            child: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Community Name",
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Community Description",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 35),
                  Center(
                      child:
                          RaisedButton(child: Text("Join US!"), onPressed: () {}))
                ],
              ),
            ),
          )

 */
