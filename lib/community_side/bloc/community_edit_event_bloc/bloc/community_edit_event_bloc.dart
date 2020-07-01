import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_edit_event_event.dart';
part 'community_edit_event_state.dart';

class CommunityEditEventBloc extends Bloc<CommunityEditEventEvent, CommunityEditEventState> {
  @override
  CommunityEditEventState get initialState => CommunityEditEventInitial();

  @override
  Stream<CommunityEditEventState> mapEventToState(
    CommunityEditEventEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
