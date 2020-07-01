import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/models/event.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  EventState get initialState => EventInitial();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    //-----------TIMELINE  - JOINED COMM-EVENTS
    if (event is FetchAllJoinedComEventsEvent) {
      yield AllEventsLoadingState();

      try {
        List<Event> myList =
            await _databaseHelper.getAllJoinedCommunityEvents(event.user_id);

        yield AllEventsLoadedState(event_list: myList);
      } catch (exception) {
        print("Error : $exception");
        yield AllEventsLoadErrorState();
      }
    }

    //-----------EXPLORE -NON JOINED COMM-EVENTS
    if (event is FetchAllNonJoinedComEventsEvent) {
      yield AllEventsLoadingState();

      try {
        List<Event> myList =
            await _databaseHelper.getAllNonJoinedCommunityEvents(event.user_id);

        yield AllEventsLoadedState(event_list: myList);
      } catch (exception) {
        print("Error : $exception");
        yield AllEventsLoadErrorState();
      }
    }

    //-----------SINGLE EVENT PAGE FROM TIMELINE
    if (event is FetchSingleJoinedComEventEvent) {
      yield SingleEventLoadingState();

      try {
        //GET SINGLE EVENT
        Event tempEvent =
            await _databaseHelper.getSingleJoinedCommunityEvent(event.event_id);

        yield SingleEventLoadedState(event: tempEvent);
      } catch (exception) {
        print("Error : $exception");
        yield SingleEventLoadErrorState();
      }
    }

    //-----------SINGLE EVENT PAGE FROM EXPLORE-EVENT
    if (event is FetchSingleNonJoinedComEventEvent) {
      //send loading state
      yield SingleEventLoadingState();

      try {
        Event tempEvent = await _databaseHelper
            .getSingleNonJoinedCommunityEvent(event.event_id);

        //if not any problem send loaded state
        yield SingleEventLoadedState(event: tempEvent);
      } catch (exception) {
        print("Error : $exception");
        yield SingleEventLoadErrorState();
      }
    }

    if (event is FetchAllJoinedEvent) {
      yield AllEventsLoadingState();

      try {
        List<Event> tempList =
            await _databaseHelper.getAllJoinedEvents(event.user_id);

        yield AllEventsLoadedState(event_list: tempList);
      } catch (exception) {
        print("ERROR : ${exception}");
        yield AllEventsLoadErrorState();
      }
    }

    if (event is FetchSingleJoinedEvent) {
      yield SingleEventLoadingState();

      try {
        Event tempEvent =
            await _databaseHelper.getSingleJoinedEvent(event.event_id);

        yield SingleEventLoadedState(event: tempEvent);
      } catch (exception) {
        print("ERROR : ${exception}");
        yield SingleEventLoadErrorState();
      }
    }

    if (event is FetchSingleCommunityEventToEdit) {
      yield SingleEventLoadingState();

      try {
        Event tempEvent =
            await _databaseHelper.getSingleCommunityEvent(event.event_id);

        yield SingleEventLoadedState(event: tempEvent);
      } catch (exception) {
        print("Error $exception");
        yield SingleEventLoadErrorState();
      }
    }
  }
}
