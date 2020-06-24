part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginLoadingState extends LoginState {

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class LoginSuccessState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class LoginNotSuccessState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}

class LoginErrorState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
  
}


