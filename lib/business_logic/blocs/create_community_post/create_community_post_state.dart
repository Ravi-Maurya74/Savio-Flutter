part of 'create_community_post_bloc.dart';

sealed class CreateCommunityPostState extends Equatable {
  const CreateCommunityPostState();

  @override
  List<Object> get props => [];
}

final class CreateCommunityPostInitial extends CreateCommunityPostState {}

final class CreateCommunityPostLoading extends CreateCommunityPostState {}

final class CreateCommunityPostLoaded extends CreateCommunityPostState {
  const CreateCommunityPostLoaded();
}

final class CreateCommunityPostError extends CreateCommunityPostState {
  const CreateCommunityPostError({required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
