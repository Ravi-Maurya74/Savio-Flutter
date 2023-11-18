import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:savio/data/models/community_post_list.dart';

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({super.key, required this.communityPostList});
  final CommunityPostList communityPostList;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Theme.of(context).cardTheme.color,
      surfaceTintColor: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (communityPostList.image != null)
            Container(
                // padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                ),
                child:
                    Image.network(communityPostList.image!, fit: BoxFit.fill)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(communityPostList.title,
                    style: Theme.of(context) // 1
                        .textTheme
                        .headlineMedium!
                        .copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                            color: Colors.white70)),
                const SizedBox(height: 2),
                Text(
                  communityPostList.content.length > 100
                      ? '${communityPostList.content.substring(0, 100)}...'
                      : communityPostList.content,
                  style: Theme.of(context).textTheme.bodyLarge, //2
                ),
                const Divider(
                  thickness: 0.9,
                ),
                ListTile(
                  visualDensity:
                      const VisualDensity(horizontal: -4, vertical: -4),
                  contentPadding: EdgeInsets.zero,
                  leading: communityPostList.author.profilePic==null? const Icon(
                    Icons.account_circle,
                    size: 35,
                  ):
                  GestureDetector(
                    onTap: () {
                      showDialog(
              context: context,
              builder: (_) {
                return CachedNetworkImage(
                          imageUrl: communityPostList.author.profilePic!,
                          placeholder: (context, url) =>
                              Center(child: SizedBox(height: 30,width: 30,child: const CircularProgressIndicator())),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                );
              },
            );
                    },
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(communityPostList.author.profilePic!),
                    ),
                  ),
                  title: Text(communityPostList.author.name,
                      style: Theme.of(context) //3
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold)),
                  trailing: FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          Icons.arrow_upward,
                          size: 20,
                          // color: communityPost.liked
                          //     ? const Color(0xFFd988a1)
                          //     : Colors.grey,
                          color: Color(0xFFd988a1),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(communityPostList.score.toString()),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
