import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  @override
  EventState get initialState => EventInitial();

  @override
  Stream<EventState> mapEventToState(EventEvent event) async* {
    // TODO: implement mapEventToState
  }
}
