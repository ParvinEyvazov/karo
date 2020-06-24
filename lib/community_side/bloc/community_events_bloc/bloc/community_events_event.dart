part of 'community_events_bloc.dart';

abstract class CommunityEventsEvent extends Equatable {
  const CommunityEventsEvent();
}

class FetchCommunityEventsInfoEvent extends CommunityEventsEvent {
  int community_id;

  FetchCommunityEventsInfoEvent({@required this.community_id})
      : assert(community_id != null);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}



class ChangeCommunityEventsInfoEvent extends CommunityEventsEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

