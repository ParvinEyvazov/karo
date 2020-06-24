import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  UserState get initialState => UserInitial();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    //FETCH USER INFORMATION TO SHOW IN PROFILE
    if (event is FetchUserInfoEvent) {
      yield UserInfoLoadingState();

      try {
        User tempUser = await _databaseHelper.getUserInfo(event.user_id);

        int joined_comm =
            await _databaseHelper.getUserJoinedCommunityNumber(event.user_id);
        int joined_event =
            await _databaseHelper.getUserJoinedEventNumber(event.user_id);

        yield UserInfoLoadedState(
            user: tempUser,
            joined_comm: joined_comm,
            joined_event: joined_event);
      } catch (exception) {
        yield UserInfoLoadErrorState();
      }
    }
  }
}
