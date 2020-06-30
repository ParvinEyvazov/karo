import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/models/comment.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  CommentState get initialState => CommentInitial();

  @override
  Stream<CommentState> mapEventToState(CommentEvent event) async* {
    //fetch all comments with using event id
    if (event is FetchAllEventCommentsEvent) {
      yield AllCommentsLoadingState();

      try {
        List<Comment> list_comment = await _databaseHelper
            .getCommentWithEventIDForUserSide(event.event_id);

        yield AllCommentsLoadedState(comment_list: list_comment);
      } catch (exception) {
        yield AllCommentsLoadErrorState();
      }
    }
  }
}
