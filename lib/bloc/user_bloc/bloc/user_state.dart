part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserInfoLoadingState extends UserState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class UserInfoLoadedState extends UserState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class UserInfoLoadErrorState extends UserState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}


