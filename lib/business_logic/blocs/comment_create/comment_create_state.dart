part of 'comment_create_bloc.dart';

sealed class CommentCreateState extends Equatable {
  const CommentCreateState();

  @override
  List<Object> get props => [];
}

final class CommentCreateInitial extends CommentCreateState {}

final class CommentCreateLoading extends CommentCreateState {}

final class CommentCreateLoaded extends CommentCreateState {
  const CommentCreateLoaded();


}

final class CommentCreateError extends CommentCreateState {
  const CommentCreateError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
