part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class FetchAllEventCommentsEvent extends CommentEvent {
  int event_id;

  FetchAllEventCommentsEvent({@required this.event_id})
      : assert(event_id != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
