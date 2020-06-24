part of 'event_bloc.dart';

abstract class EventState extends Equatable {
  const EventState();
}

//-----------INITIAL-----------
class EventInitial extends EventState {
  @override
  List<Object> get props => [];
}

//-----------MULTI EVENT STATES-----------
class AllEventsLoadingState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class AllEventsLoadedState extends EventState{

  List<Event> event_list;

  AllEventsLoadedState({@required this.event_list}) : assert(event_list != null);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class AllEventsLoadErrorState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}


//-----------SINGLE EVENT STATES-----------
class SingleEventLoadingState extends EventState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class SingleEventLoadedState extends EventState{

  Event event;

  SingleEventLoadedState({@required this.event}) : assert(event != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class SingleEventLoadErrorState extends EventState{

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}
