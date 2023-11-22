part of 'single_comment_bloc.dart';

sealed class SingleCommentEvent extends Equatable {
  const SingleCommentEvent();

  @override
  List<Object> get props => [];
}

final class AddLikeDislikeSingleCommentEvent extends SingleCommentEvent {
  const AddLikeDislikeSingleCommentEvent({required this.vote});
  final int vote;
}

final class RemoveLikeDislikeSingleCommentEvent extends SingleCommentEvent {
  const RemoveLikeDislikeSingleCommentEvent({required this.vote});
  final int vote;
}

final class ChangeLikeDislikeSingleCommentEvent extends SingleCommentEvent {
  const ChangeLikeDislikeSingleCommentEvent({required this.vote});
  final int vote;
}
