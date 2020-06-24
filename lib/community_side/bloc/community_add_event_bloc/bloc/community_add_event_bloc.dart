import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_add_event_event.dart';
part 'community_add_event_state.dart';

class CommunityAddEventBloc extends Bloc<CommunityAddEventEvent, CommunityAddEventState> {
  @override
  CommunityAddEventState get initialState => CommunityAddEventInitial();

  @override
  Stream<CommunityAddEventState> mapEventToState(
    CommunityAddEventEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
