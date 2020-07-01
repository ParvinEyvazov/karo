part of 'community_event_comments_bloc.dart';

abstract class CommunityEventCommentsState extends Equatable {
  const CommunityEventCommentsState();
}

class CommunityEventCommentsInitial extends CommunityEventCommentsState {
  @override
  List<Object> get props => [];
}

class CommunityEventCommentsLoadingState extends CommunityEventCommentsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommunityEventCommentsLoadedState extends CommunityEventCommentsState {
  List<Comment> comments;

  CommunityEventCommentsLoadedState({@required this.comments})
      : assert(comments != null);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommunityEventCommentsLoadErrorState extends CommunityEventCommentsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
