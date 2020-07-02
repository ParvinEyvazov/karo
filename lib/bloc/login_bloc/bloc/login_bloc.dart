import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState

    if (event is LoginCheckEvent) {
      yield LoginLoadingState();

      try {
        int user_id = event.user_id;
        String user_password = event.user_password;

        //get bu id ve password ile tabloda olub olmadigi yoxla
        List<User> checkUser =
            await _databaseHelper.getUser(user_id, user_password);

        //var ise LoginSuccess yox ise LoginNotSuccess
        if (checkUser.length != 0) {
          yield LoginSuccessState();
        } else {
          yield LoginNotSuccessState();
        }
      } catch (exception) {
        yield LoginErrorState();
      }
    }

    if (event is CommunityLoginCheckEvent) {
      yield LoginLoadingState();

      try {
        int community_id = event.community_id;
        String community_password = event.community_password;

        List<Community> checkCommunity = await _databaseHelper.getCommunity(
            community_id, community_password);

        if (checkCommunity.length != 0) {
          yield LoginSuccessState();
        } else {
          yield LoginNotSuccessState();
        }
      } catch (e) {
        yield LoginErrorState();
      }
    }
  }
}
