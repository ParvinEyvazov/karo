import 'dart:async';
import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  @override
  CommunityState get initialState => CommunityInitial();

  @override
  Stream<CommunityState> mapEventToState(CommunityEvent event) async* {
    // TODO: implement mapEventToState
  }
}
