part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();
}

// for multi community
class FetchAllJoinedCommunityEvent extends CommunityEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class FetchAllNonJoinedCommunityEvent extends CommunityEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

//for single community
class FetchSingleJoinedCommunityEvent extends CommunityEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class FetchSingleNonJoinedCommunityEvent extends CommunityEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
