part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginCheckEvent extends LoginEvent {

  final int user_id;
  final String user_password;

  LoginCheckEvent({@required this.user_id, @required this.user_password}) : assert(user_id != null &&  user_password != null);


  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
