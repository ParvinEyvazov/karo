import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';

class SingleJoinedCommunityPage extends StatefulWidget {
  int comm_id;

  SingleJoinedCommunityPage({@required this.comm_id}) : assert(comm_id != null);

  @override
  _SingleJoinedCommunityPageState createState() =>
      _SingleJoinedCommunityPageState();
}

class _SingleJoinedCommunityPageState extends State<SingleJoinedCommunityPage> {
  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("joined com"),
      ),
      body: BlocBuilder(
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
            if(state is SingleCommunityLoadedState){
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
                    
                  ],
                ),
              );
            }

            //ERROR STATE
            if(state is SingleCommunityLoadErrorState){
              return Center(child: Text("ERROR"),);
            }

          }),
    );
  }
}
