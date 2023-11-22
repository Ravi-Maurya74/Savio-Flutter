part of 'create_community_post_bloc.dart';

final class CreateCommunityPostEvent extends Equatable {
  const CreateCommunityPostEvent({required this.title, required this.content, this.image});
  final String title;
  final String content;
  final File? image;

  @override
  List<Object> get props => [title, content];
}
