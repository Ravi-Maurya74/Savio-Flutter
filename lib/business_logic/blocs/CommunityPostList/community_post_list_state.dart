part of 'community_post_list_bloc.dart';

sealed class CommunityPostListState extends Equatable {
  const CommunityPostListState();
  
  @override
  List<Object> get props => [];
}

final class CommunityPostListInitial extends CommunityPostListState {}

final class CommunityPostListLoading extends CommunityPostListState {}

final class CommunityPostListLoaded extends CommunityPostListState {
  const CommunityPostListLoaded(this.communityPostList);

  final List<CommunityPostList> communityPostList;

  @override
  List<Object> get props => [communityPostList];
}

final class CommunityPostListError extends CommunityPostListState {
  const CommunityPostListError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
