part of 'single_community_post_bloc.dart';

sealed class SingleCommunityPostEvent extends Equatable {
  const SingleCommunityPostEvent();

  @override
  List<Object> get props => [];
}

final class GetSingleCommunityPostEvent extends SingleCommunityPostEvent {
  const GetSingleCommunityPostEvent();
}

final class TestEvent extends SingleCommunityPostEvent {
  const TestEvent();
}

final class BookMarkSingleCommunityPostEvent extends SingleCommunityPostEvent {
  const BookMarkSingleCommunityPostEvent();
}

final class AddLikeDislikeSingleCommunityPostEvent
    extends SingleCommunityPostEvent {
  const AddLikeDislikeSingleCommunityPostEvent({required this.vote});
  final int vote;
}

final class RemoveLikeDislikeSingleCommunityPostEvent
    extends SingleCommunityPostEvent {
  const RemoveLikeDislikeSingleCommunityPostEvent({required this.vote});
  final int vote;
}

final class ChangeLikeDislikeSingleCommunityPostEvent
    extends SingleCommunityPostEvent {
  const ChangeLikeDislikeSingleCommunityPostEvent({required this.vote});
  final int vote;
}
