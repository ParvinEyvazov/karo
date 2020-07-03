import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karo_app/bloc/comment_bloc/bloc/comment_bloc.dart';
import 'package:karo_app/community_side/bloc/community_event_comments_bloc/bloc/community_event_comments_bloc.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/community_side/components/build_comment_tile.dart';
import 'package:karo_app/community_side/components/custom_confirmation_dialog.dart';
import 'package:karo_app/models/comment.dart';
import 'package:karo_app/utils/database_helper.dart';

class CommunityEventCommentsPage extends StatefulWidget {
  int event_id;
  CommunityEventCommentsPage({@required this.event_id});
  @override
  _CommunityEventCommentsPageState createState() =>
      _CommunityEventCommentsPageState();
}

class _CommunityEventCommentsPageState
    extends State<CommunityEventCommentsPage> {
  DatabaseHelper _databaseHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    final _communityCommentBloc = BlocProvider.of<CommentBloc>(context);
    return BlocBuilder(
      bloc: _communityCommentBloc,
      builder: (context, CommentState state) {
        if (state is CommentInitial) {
          _communityCommentBloc
              .add(FetchAllEventCommentsEvent(event_id: widget.event_id));
          return Center(child: CircularProgressIndicator());
        }

        if (state is AllCommentsLoadingState) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is AllCommentsLoadedState) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: state.comment_list.length,
              itemBuilder: (context, index) {
                Comment comment = state.comment_list[index];
                if (state.comment_list.length != 0) {
                  //print(comment);
                  return BuildCommentTile(
                      userName: comment.userName == null
                          ? "USERNAME"
                          : comment.userName,
                      userSurname: comment.userSurname == null
                          ? "SURNAME"
                          : comment.userSurname,
                      dateTime:
                          comment.dateTime == null ? "DATE" : comment.dateTime,
                      eventId: comment.eventId == null ? 0 : comment.eventId,
                      text: comment.text == null ? "TEXT" : comment.text,
                      userId: comment.userId == null ? 0 : comment.userId,
                      deleted: comment.deleted == null ? 0 : comment.deleted,
                      onPressed: () {
                        CustomConfirmationDialog(
                          onPressedYes: () {
                            setState(() {
                              setState(() {
                                Future(() {
                                  setState(() {
                                    deleteEvent(comment.commentId);
                                  });
                                });
                                Navigator.pop(context, () {
                                  setState(() {});
                                });
                              });
                            });
                          },
                          onPressedNo: () {
                            setState(() {
                              Navigator.pop(context, () {
                                setState(() {});
                              });
                            });
                          },
                        ).build(context);
                      });
                } else {
                  print("A");
                  return Center(
                    child: Text("No comment.."),
                  );
                }
              });
        }

        if (state is AllCommentsLoadErrorState) {
          return Center(
            child: Text("No comment.."),
          );
        }
      },
    );
  }

  deleteEvent(int comment_id) async {
    print(comment_id);
    await _databaseHelper.deleteEventComment(comment_id);
  }
}
