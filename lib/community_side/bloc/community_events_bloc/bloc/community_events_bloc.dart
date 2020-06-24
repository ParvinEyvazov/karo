import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../bloc/user_bloc/bloc/user_bloc.dart';
import '../../../../models/event.dart';
import '../../../../ui/profile_page.dart';
import '../../../../utils/database_helper.dart';
import '../../../../utils/database_helper.dart';

part 'community_events_event.dart';
part 'community_events_state.dart';

class CommunityEventsBloc
    extends Bloc<CommunityEventsEvent, CommunityEventsState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  CommunityEventsState get initialState => CommunityEventsInitial();

  @override
  Stream<CommunityEventsState> mapEventToState(
      CommunityEventsEvent event) async* {
    if (event is FetchCommunityEventsInfoEvent) {
      yield CommunityEventsLoadingState();

      try {
        List<Event> community_events =
            await _databaseHelper.getCommunityEvents(event.community_id);
        List<int> numbers = await _databaseHelper.getEventJoinedUsers(event.community_id);

        yield CommunityEventsLoadedState(
            events: community_events, numbers: numbers);
      } catch (exception) {
        print("Error $exception");
        yield CommunityEventsLoadErrorState();
      }
    }
  }
}
