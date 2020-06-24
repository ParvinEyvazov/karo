part of 'community_events_bloc.dart';

abstract class CommunityEventsState extends Equatable {
  const CommunityEventsState();
}

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
  List<int> numbers;

  CommunityEventsLoadedState({@required this.events, @required this.numbers})
      : assert(events != null && numbers != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CommunityEventsLoadErrorState extends CommunityEventsState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
