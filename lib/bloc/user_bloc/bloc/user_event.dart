part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserInfoEvent extends UserEvent{

  int user_id;

  FetchUserInfoEvent({@required this.user_id}) : assert(user_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}

class ChangeUserInfoEvent extends UserEvent{

  List<Object> get props => throw UnimplementedError();

}
