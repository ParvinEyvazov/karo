import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/community_side/bloc/community_events_bloc/bloc/community_events_bloc.dart';
import 'package:karo_app/models/comment.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'community_event_comments_event.dart';
part 'community_event_comments_state.dart';

class CommunityEventCommentsBloc
    extends Bloc<CommunityEventCommentsEvent, CommunityEventCommentsState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  CommunityEventCommentsState get initialState =>
      CommunityEventCommentsInitial();

  @override
  Stream<CommunityEventCommentsState> mapEventToState(
    CommunityEventCommentsEvent event,
  ) async* {
    if (event is FetchCommunityEventComments) {
      yield CommunityEventCommentsLoadingState();

      try {
        List<Comment> comments =
            await _databaseHelper.getEventComment(event.event_id);

        yield CommunityEventCommentsLoadedState(comments: comments);
      } catch (exception) {
        print("Error $exception");
        yield CommunityEventCommentsLoadErrorState();
      }
    }
    // TODO: implement mapEventToState
  }
}
