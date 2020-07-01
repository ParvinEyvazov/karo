import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/community_bloc/bloc/community_bloc.dart';
import 'package:karo_app/community_side/components/custom_box_decoration.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityMembersPage extends StatefulWidget {
  int community_id;

  CommunityMembersPage({@required this.community_id});

  @override
  _CommunityMembersPageState createState() => _CommunityMembersPageState();
}

class _CommunityMembersPageState extends State<CommunityMembersPage> {
  DatabaseHelper _databaseHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityBloc = BlocProvider.of<CommunityBloc>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
      ),
      body: BlocBuilder(
        bloc: _communityBloc,
        builder: (context, CommunityState state) {
          if (state is CommunityInitial) {
            _communityBloc.add(
                FetchCommunityMembersEvent(community_id: widget.community_id));
            return Center(child: CircularProgressIndicator());
          }
          if (state is CommunityMembersLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CommunityMembersLoadedState) {
            print(state.user.length);
            return Container(
              child: ListView.builder(
                itemCount: state.user.length,
                itemBuilder: (context, index) {
                  print(state.user[index]);
                  return card(
                      widget.community_id,
                      state.user[index].userID,
                      state.user[index].userName,
                      state.user[index].userSurname,
                      _communityBloc);
                },
              ),
            );
          }
        },
      ),
    );
  }

  card(int community_id, int user_id, String userName, String userSurname,
      CommunityBloc bloc) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: CustomBoxDecoration().create(Colors.blue, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("${userName}  ${userSurname}"),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print("Clicked");
              setState(() {
                bloc.add(FetchCommunityMembersEvent(
                    community_id: widget.community_id));
                deleteMember(user_id, community_id);
              });
            },
          )
        ],
      ),
    );
  }

  deleteMember(int user_id, int community_id) {
    print("deleted");
    _databaseHelper.deleteUserFromCommunity(user_id, community_id);
  }
}
