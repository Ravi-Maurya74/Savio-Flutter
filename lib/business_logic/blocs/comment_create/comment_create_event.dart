part of 'comment_create_bloc.dart';

final class CommentCreateEvent extends Equatable {
  const CommentCreateEvent({required this.onCommentCreate,required this.content});
  final VoidCallback onCommentCreate;
  final String content;

  @override
  List<Object> get props => [];
}
