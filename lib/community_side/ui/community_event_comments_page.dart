import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/community_side/bloc/community_event_comments_bloc/bloc/community_event_comments_bloc.dart';
import 'package:karo_app/community_side/components/build_comment_tile.dart';

class CommunityEvenCommentsPage extends StatefulWidget {
  int event_id;
  CommunityEvenCommentsPage({@required this.event_id});
  @override
  _CommunityEvenCommentsPageState createState() =>
      _CommunityEvenCommentsPageState();
}

class _CommunityEvenCommentsPageState extends State<CommunityEvenCommentsPage> {
  @override
  Widget build(BuildContext context) {
    final _communityEventCommentsBloc =
        BlocProvider.of<CommunityEventCommentsBloc>(context);
    return BlocBuilder(
      bloc: _communityEventCommentsBloc,
      builder: (context, CommunityEventCommentsState state) {
        if (state is CommunityEventCommentsInitial) {
          _communityEventCommentsBloc
              .add(FetchCommunityEventComments(event_id: widget.event_id));
          return Center(child: CircularProgressIndicator());
        }

        if (state is CommunityEventCommentsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is CommunityEventCommentsLoadedState) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.comments.length,
              itemBuilder: (context, index) {
                if (state.comments.length != 0) {
                  return BuildCommentTile(
                    userName: state.comments[index].userId.toString(),
                    commentText: state.comments[index].text,
                    dateTime: state.comments[index].dateTime,
                  );
                } else {
                  print("A");
                  return Center(
                    child: Text("No comment.."),
                  );
                }
              });
        }

        if (state is CommunityEventCommentsLoadErrorState) {
          return Center(
            child: Text("No comment.."),
          );
        }
      },
    );
  }
}
