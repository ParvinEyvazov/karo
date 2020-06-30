part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class AllCommentsLoadingState extends CommentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AllCommentsLoadedState extends CommentState {
  List<Comment> comment_list;

  AllCommentsLoadedState({@required this.comment_list})
      : assert(comment_list != null);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class AllCommentsLoadErrorState extends CommentState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
