part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserInfoLoadingState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserInfoLoadedState extends UserState {
  User user;
  int joined_comm;
  int joined_event;

  UserInfoLoadedState({
    @required this.user,
    @required this.joined_comm,
    @required this.joined_event,
  }) : assert(user != null && joined_comm != null && joined_event != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class UserInfoLoadErrorState extends UserState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
