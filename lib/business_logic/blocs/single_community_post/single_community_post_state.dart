part of 'single_community_post_bloc.dart';

sealed class SingleCommunityPostState extends Equatable {
  const SingleCommunityPostState();
  
  @override
  List<Object> get props => [];
}

final class SingleCommunityPostInitial extends SingleCommunityPostState {}

final class SingleCommunityPostLoading extends SingleCommunityPostState {}

final class SingleCommunityPostLoaded extends SingleCommunityPostState {
  const SingleCommunityPostLoaded({required this.singleCommunityPost});
  final SingleCommunityPost singleCommunityPost;

  @override
  List<Object> get props => [singleCommunityPost];
}

final class SingleCommunityPostError extends SingleCommunityPostState {
  const SingleCommunityPostError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
