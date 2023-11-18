part of 'community_post_list_bloc.dart';

sealed class CommunityPostListEvent extends Equatable {
  const CommunityPostListEvent();

  @override
  List<Object> get props => [];
}

final class GetCommunityPostListEvent extends CommunityPostListEvent {}
