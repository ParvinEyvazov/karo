import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_profile_event.dart';
part 'community_profile_state.dart';

class CommunityProfileBloc extends Bloc<CommunityProfileEvent, CommunityProfileState> {
  @override
  CommunityProfileState get initialState => CommunityProfileInitial();

  @override
  Stream<CommunityProfileState> mapEventToState(
    CommunityProfileEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
