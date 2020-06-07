part of 'community_bloc.dart';

abstract class CommunityState extends Equatable {
  const CommunityState();
}

class CommunityInitial extends CommunityState {
  @override
  List<Object> get props => [];
}

//for multi community
class AllCommunityLoadingState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AllCommunityLoadedState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class AllCommunityLoadErrorState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

//for single community
class SingleCommunityLoadingState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class SingleCommunityLoadedState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class SingleCommunityLoadErrorState extends CommunityState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
