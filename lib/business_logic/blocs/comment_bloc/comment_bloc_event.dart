part of 'comment_bloc_bloc.dart';

sealed class CommentBlocEvent extends Equatable {
  const CommentBlocEvent();

  @override
  List<Object> get props => [];
}

final class GetCommentBlocEvent extends CommentBlocEvent {
  const GetCommentBlocEvent();
}


