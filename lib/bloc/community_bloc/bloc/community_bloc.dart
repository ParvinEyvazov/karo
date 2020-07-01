import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:karo_app/models/community.dart';
import 'package:karo_app/models/user.dart';
import 'package:karo_app/utils/database_helper.dart';

part 'community_event.dart';
part 'community_state.dart';

class CommunityBloc extends Bloc<CommunityEvent, CommunityState> {
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  CommunityState get initialState => CommunityInitial();

  @override
  Stream<CommunityState> mapEventToState(CommunityEvent event) async* {
    //profile part --FETCH ALL JOINED COMMUNITY
    if (event is FetchAllJoinedCommunityEvent) {
      yield AllCommunityLoadingState();

      try {
        List<Community> myList =
            await _databaseHelper.getAllJoinedCommunity(event.user_id);

        yield AllCommunityLoadedState(community_list: myList);
      } catch (exception) {
        print("ERROR : $exception");
        yield AllCommunityLoadErrorState();
      }
    }

    // EXPLORE PART - FETCH ALL NON JOINED COMMUNITY
    if (event is FetchAllNonJoinedCommunityEvent) {
      yield AllCommunityLoadingState();

      try {
        List<Community> myList =
            await _databaseHelper.getAllNonJoinedCommunity(event.user_id);

        yield AllCommunityLoadedState(community_list: myList);
      } catch (exception) {
        print("Error : $exception");
        yield AllCommunityLoadErrorState();
      }
    }

    if (event is FetchSingleNonJoinedCommunityEvent) {
      yield SingleCommunityLoadingState();

      try {
        Community tempComm =
            await _databaseHelper.getSingleNonJoinedCommunity(event.comm_id);

        yield SingleCommunityLoadedState(community: tempComm);
      } catch (exception) {
        print("Error : $exception");
        yield SingleCommunityLoadErrorState();
      }
    }

    if (event is FetchSingleJoinedCommunityEvent) {
      yield SingleCommunityLoadingState();

      try {
        Community tempComm =
            await _databaseHelper.getSingleJoinedCommunity(event.comm_id);

        yield SingleCommunityLoadedState(community: tempComm);
      } catch (exception) {
        print("Error : $exception");
        yield SingleCommunityLoadErrorState();
      }
    }

    if (event is FetchSingleCommunityEvent) {
      yield SingleCommunityLoadingState();

      try {
        Community tempComm =
            await _databaseHelper.getSingleCommunity(event.community_id);
        yield SingleCommunityLoadedState(community: tempComm);
      } catch (exception) {
        print("Error : $exception");
        yield SingleCommunityLoadErrorState();
      }
    }

    if (event is FetchCommunityMembersEvent) {
      yield CommunityMembersLoadingState();

      try {
        List<User> user =
            await _databaseHelper.getCommunityMembers(event.community_id);
        yield CommunityMembersLoadedState(user: user);
      } catch (exception) {
        print("Error : $exception");
        yield CommunityMembersLoadErrorState();
      }
    }
  }
}
