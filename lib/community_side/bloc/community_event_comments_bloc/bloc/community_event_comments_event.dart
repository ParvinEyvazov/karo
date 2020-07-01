part of 'community_event_comments_bloc.dart';

abstract class CommunityEventCommentsEvent extends Equatable {
  const CommunityEventCommentsEvent();
}

class FetchCommunityEventComments extends CommunityEventCommentsEvent {
  int event_id;

  FetchCommunityEventComments({@required this.event_id})
      : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
