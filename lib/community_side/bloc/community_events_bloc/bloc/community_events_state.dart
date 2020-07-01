part of 'community_events_bloc.dart';

abstract class CommunityEventsState extends Equatable {
  const CommunityEventsState();
}
//////////Get All Events of Community
class CommunityEventsInitial extends CommunityEventsState {
  @override
  List<Object> get props => [];
}

class CommunityEventsLoadingState extends CommunityEventsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommunityEventsLoadedState extends CommunityEventsState {
  List<Event> events;
  Map joined_members;

  CommunityEventsLoadedState(
      {@required this.events, @required this.joined_members})
      : assert(events != null && joined_members != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommunityEventsLoadErrorState extends CommunityEventsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}