part of 'event_bloc.dart';

abstract class EventEvent extends Equatable {
  const EventEvent();
}

class FetchAllJoinedComEventsEvent extends EventEvent{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  
}

class FetchAllNonJoinedComEventsEvent extends EventEvent{
  
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  
}

class FetchSingleJoinedComEventEvent extends EventEvent{
  
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  
}

class FetchSingleNonJoinedComEventEvent extends EventEvent{
  
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

  
}

