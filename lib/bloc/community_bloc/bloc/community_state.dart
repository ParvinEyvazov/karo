part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();
}


////-----------------------------INITIAL STATE-----------------------------
class CommunityInitial extends CommunityState {
  @override
  List<Object> get props => [];
}




//-----------------------------ALL COMMUNITY LIST STATES-----------------------------
class AllCommunityLoadingState extends CommunityState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AllCommunityLoadedState extends CommunityState {
  List<Community> community_list;

  AllCommunityLoadedState({@required this.community_list});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AllCommunityLoadErrorState extends CommunityState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}








//-----------------------------SINGLE COMMUNITY STATES-----------------------------
class SingleCommunityLoadingState extends CommunityState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SingleCommunityLoadedState extends CommunityState {

  Community community;

  SingleCommunityLoadedState({@required this.community}) : assert(community != null);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SingleCommunityLoadErrorState extends CommunityState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
