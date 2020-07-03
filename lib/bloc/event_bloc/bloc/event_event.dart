part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

//----------------MULTI----------------
//------TIMELINE-----
class FetchAllJoinedComEventsEvent extends EventEvent {
  int user_id;

  FetchAllJoinedComEventsEvent({@required this.user_id})
      : assert(user_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//------EXPLORE - EVENT -----
class FetchAllNonJoinedComEventsEvent extends EventEvent {
  int user_id;

  FetchAllNonJoinedComEventsEvent({@required this.user_id})
      : assert(user_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//------EVENT LIST PAGE THROUGH PROFILE-----
class FetchAllJoinedEvent extends EventEvent {
  int user_id;

  FetchAllJoinedEvent({@required this.user_id}) : assert(user_id != null);

  List<Object> get props => throw UnimplementedError();
}

class FetchCommunityEventsEvent extends EventEvent {
  int community_id;

  FetchCommunityEventsEvent({@required this.community_id})
      : assert(community_id != null);

  List<Object> get props => throw UnimplementedError();
}

//----------------SINGLE----------------
//------EVENT PAGE THROUGH TIMELINE-----
class FetchSingleJoinedComEventEvent extends EventEvent {
  int event_id;

  FetchSingleJoinedComEventEvent({@required this.event_id})
      : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//------EVENT PAGE THROUGH EXPLORE-EVENT-----
class FetchSingleNonJoinedComEventEvent extends EventEvent {
  int event_id;

  FetchSingleNonJoinedComEventEvent({@required this.event_id})
      : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

//------EVENT PAGE THROUGH PROFILE-----
class FetchSingleJoinedEvent extends EventEvent {
  int event_id;

  FetchSingleJoinedEvent({@required this.event_id}) : assert(event_id != null);

  List<Object> get props => throw UnimplementedError();
}

//------CHOSEN COMMUNTIY EVENT TO EDIT--------
class FetchSingleCommunityEventToEdit extends EventEvent {
  int event_id;

  FetchSingleCommunityEventToEdit({@required this.event_id})
      : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchSingleEvent extends EventEvent {
  int event_id;

  FetchSingleEvent(@required this.event_id) : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchAllCommunityEvents extends EventEvent {
  int community_id;

  FetchAllCommunityEvents({@required this.community_id})
      : assert(community_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
