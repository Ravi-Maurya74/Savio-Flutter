part of 'single_comment_bloc.dart';

final class SingleCommentState extends Equatable {
  const SingleCommentState({required this.comment});
  final Comment comment;
  
  @override
  List<Object> get props => [comment];
}

