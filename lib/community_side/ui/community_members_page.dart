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
    return BlocBuilder(
      bloc: _communityBloc,
      builder: (context, state) {
        if (state is CommunityInitial) {
          _communityBloc.add(
              FetchCommunityMembersEvent(community_id: widget.community_id));
          return Center(child: CircularProgressIndicator());
        }
        if (state is CommunityMembersLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is CommunityMembersLoadedState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return card(
                widget.community_id,
                state.user[index].userID,
                state.user[index].userName,
                state.user[index].userSurname,
              );
            },
          );
        }
      },
    );
  }

  card(
    int community_id,
    int user_id,
    String userName,
    String userSurname,
  ) {
    return Container(
      decoration: CustomBoxDecoration().create(Colors.blue, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("${userName} + ${userSurname}"),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              deleteMember(user_id, community_id);
            },
          )
        ],
      ),
    );
  }

  deleteMember(int user_id, int community_id) {
    _databaseHelper.deleteUserFromCommunity(user_id, community_id);
  }
}
