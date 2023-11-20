import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/comment_bloc/comment_bloc_bloc.dart';
import 'package:savio/business_logic/blocs/single_community_post/single_community_post_bloc.dart';
import 'package:savio/data/models/comment.dart';
import 'package:savio/data/models/single_community_post.dart';
import 'package:shimmer/shimmer.dart';

class CommunityPostScreen extends StatelessWidget {
  const CommunityPostScreen({super.key, required this.postId});
  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SingleCommunityPostBloc>(
      create: (context) => SingleCommunityPostBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
        postId: postId,
      ),
      child: WillPopScope(
        onWillPop: () {
          // Navigator.pop(
          //     context, Provider.of<CommunityPost>(context, listen: false));
          return Future.value(true);
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Blog'),
          ),
          // floatingActionButton: OpenContainer(
          //   transitionDuration: const Duration(milliseconds: 500),
          //   transitionType: ContainerTransitionType.fadeThrough,
          //   closedShape: const CircleBorder(),
          //   closedColor: const Color(0xFF50559a),
          //   openColor: Theme.of(context)
          //       .scaffoldBackgroundColor, //const Color(0xFF16161e),
          //   middleColor: const Color(0xFFd988a1),
          //   closedBuilder: (context, action) => Container(
          //     margin: const EdgeInsets.all(16),
          //     decoration: const BoxDecoration(
          //       color: Color(0xFF50559a),
          //     ),
          //     child: const Icon(
          //       Icons.add,
          //       size: 25,
          //       color: Color.fromARGB(255, 216, 216, 216),
          //     ),
          //   ),
          //   openBuilder: (context, action) => Container(),
          // ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PostBuilder(),
                Comments(
                  postId: postId,
                ),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PostBuilder extends StatelessWidget {
  const PostBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCommunityPostBloc, SingleCommunityPostState>(
      builder: (context, state) {
        if (state is SingleCommunityPostLoaded) {
          return const Post();
        } else if (state is SingleCommunityPostError) {
          return Center(child: Text(state.message));
        } else {
          return const PostLoading();
        }
      },
    );
  }
}

class PostLoading extends StatelessWidget {
  const PostLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Mimic the title
            Container(
              width: double.infinity,
              height: 24.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            // Mimic the main image
            Container(
              width: double.infinity,
              height: 200.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
            ),
            // Mimic the text
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4.0),
            ),
            Container(
              width: double.infinity,
              height: 8.0,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class Comments extends StatelessWidget {
  const Comments({super.key, required this.postId, this.commentId = 0});
  final int postId;
  final int commentId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommentBloc, CommentBlocState>(
      builder: (context, state) {
        if (state is CommentBlocLoaded) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return CommentWidget(
                key: ValueKey(state.commentList[index].id),
                comment: state.commentList[index],
              );
            },
            itemCount: state.commentList.length,
          );
        } else if (state is CommentBlocError) {
          return Center(child: Text(state.error));
        } else {
          return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 30, width: 30, child: CircularProgressIndicator()),
              ));
        }
      },
      bloc: CommentBloc(
        authToken: context.read<AuthCubit>().state.authToken!,
        dio: Dio(),
        postId: postId,
        commentId: commentId,
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.comment});
  final Comment comment;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool showComments = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: Colors.grey, width: 1)),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            enableFeedback: true,
            onTap: () {
                  setState(() {
                    showComments = !showComments;
                  });
                },
              title: Text(widget.comment.content),
              // trailing: IconButton(
              //   onPressed: () {
              //     setState(() {
              //       showComments = !showComments;
              //     });
              //   },
              //   icon: const Icon(Icons.comment),
              // ),
              ),
        ),
        if (showComments)
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Comments(
                postId: widget.comment.post, commentId: widget.comment.id),
          ),
      ],
    );
  }
}

class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    SingleCommunityPost singleCommunityPost =
        (BlocProvider.of<SingleCommunityPostBloc>(context, listen: false).state
                as SingleCommunityPostLoaded)
            .singleCommunityPost;
    var inputDate = DateTime.parse(singleCommunityPost.created_at);
    var outputDate = DateFormat('dd/MM/yyyy').format(inputDate);
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(top: 10, bottom: 0, left: 14, right: 14),
      decoration: BoxDecoration(
          color: const Color.fromRGBO(37, 42, 52, 1),
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: EdgeInsets.zero,
            leading: singleCommunityPost.author.profilePic == null
                ? const Icon(
                    Icons.account_circle,
                    size: 35,
                  )
                : GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) {
                          return CachedNetworkImage(
                            imageUrl: singleCommunityPost.author.profilePic!,
                            placeholder: (context, url) => const Center(
                                child: SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: CircularProgressIndicator())),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          NetworkImage(singleCommunityPost.author.profilePic!),
                    ),
                  ),
            title: Text(
              singleCommunityPost.author.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            trailing: Text(outputDate,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.normal, fontSize: 14)),
          ),
          const Divider(
            thickness: 0.9,
          ),
          Text(singleCommunityPost.title,
              style: Theme.of(context) // 1
                  .textTheme
                  .headlineMedium!
                  .copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      color: Colors.white70)),
          if (singleCommunityPost.image != null)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Image(
                image: NetworkImage(singleCommunityPost.image!),
                fit: BoxFit.cover,
              ),
            ),
          Text(
            singleCommunityPost.content,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 15),
          ),
          const Activity()
        ],
      ),
    );
  }
}

class Activity extends StatelessWidget {
  const Activity({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleCommunityPostBloc, SingleCommunityPostState>(
      builder: (context, state) {
        SingleCommunityPost singleCommunityPost =
            (state as SingleCommunityPostLoaded).singleCommunityPost;
        print(singleCommunityPost.vote);
        return Row(
          children: [
            const Spacer(),
            IconButton(
                onPressed: () {
                  context
                      .read<SingleCommunityPostBloc>()
                      .add(const BookMarkSingleCommunityPostEvent());
                },
                icon: singleCommunityPost.is_bookmarked
                    ? const Icon(Icons.bookmark_add)
                    : const Icon(Icons.bookmark_add_outlined)),
            IconButton(
              onPressed: () {
                if (singleCommunityPost.vote == null) {
                  context.read<SingleCommunityPostBloc>().add(
                      const AddLikeDislikeSingleCommunityPostEvent(vote: 1));
                } else if (singleCommunityPost.vote == 1) {
                  context.read<SingleCommunityPostBloc>().add(
                      const RemoveLikeDislikeSingleCommunityPostEvent(vote: 1));
                } else if (singleCommunityPost.vote == -1) {
                  context.read<SingleCommunityPostBloc>().add(
                      const ChangeLikeDislikeSingleCommunityPostEvent(vote: 1));
                }
              },
              icon: Icon(
                Icons.thumb_up,
                color: singleCommunityPost.vote != null &&
                        singleCommunityPost.vote == 1
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            IconButton(
              onPressed: () {
                if (singleCommunityPost.vote == null) {
                  context.read<SingleCommunityPostBloc>().add(
                      const AddLikeDislikeSingleCommunityPostEvent(vote: -1));
                } else if (singleCommunityPost.vote == 1) {
                  context.read<SingleCommunityPostBloc>().add(
                      const ChangeLikeDislikeSingleCommunityPostEvent(
                          vote: -1));
                } else if (singleCommunityPost.vote == -1) {
                  context.read<SingleCommunityPostBloc>().add(
                      const RemoveLikeDislikeSingleCommunityPostEvent(
                          vote: -1));
                }
              },
              icon: Icon(
                Icons.thumb_down,
                color: singleCommunityPost.vote != null &&
                        singleCommunityPost.vote == -1
                    ? Colors.blue
                    : Colors.grey,
              ),
            ),
            Text(
              singleCommunityPost.score.toString(),
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
            ),
          ],
        );
      },
    );
  }
}
