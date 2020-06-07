part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class FetchUserInfoEvent extends UserEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
