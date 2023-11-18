part of 'single_community_post_bloc.dart';

sealed class SingleCommunityPostEvent extends Equatable {
  const SingleCommunityPostEvent();

  @override
  List<Object> get props => [];
}

final class GetSingleCommunityPost extends SingleCommunityPostEvent {
  const GetSingleCommunityPost();
}
