part of 'comment_bloc_bloc.dart';

sealed class CommentBlocState extends Equatable {
  const CommentBlocState();
  
  @override
  List<Object> get props => [];
}

final class CommentBlocInitial extends CommentBlocState {}

final class CommentBlocLoading extends CommentBlocState {}

final class CommentBlocLoaded extends CommentBlocState {
  const CommentBlocLoaded({required this.commentList});
  final List<Comment> commentList;

  @override
  List<Object> get props => [commentList];
}

final class CommentBlocError extends CommentBlocState {
  const CommentBlocError(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
