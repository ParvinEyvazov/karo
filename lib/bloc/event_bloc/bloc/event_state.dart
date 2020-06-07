part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
}

class EventInitial extends EventState {
  @override
  List<Object> get props => [];
}

// for Multi Events
class AllEventsLoadingState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class AllEventsLoadedState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class AllEventsLoadErrorState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}


//for Single Event
class SingleEventLoadingState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class SingleEventLoadedState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class SingleEventLoadErrorState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
