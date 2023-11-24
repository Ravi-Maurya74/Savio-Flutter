import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/community_post_list.dart';
import 'package:savio/presentation/screens/community_post_screen.dart';
import 'package:savio/presentation/widgets/user_profile_pic.dart';
import 'package:shimmer/shimmer.dart';

class CommunityPostCard extends StatelessWidget {
  const CommunityPostCard({super.key, required this.communityPostList});
  final CommunityPostList communityPostList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CommunityPostScreen(postId: communityPostList.id),
            ));
      },
      child: Card(
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
                  child: CachedNetworkImage(
          imageUrl: communityPostList.image!,
          fit: BoxFit.fill,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor:
                  Colors.grey[300]!, // Starting color of the shimmer effect
              highlightColor:
                  Colors.grey[100]!, // Ending color of the shimmer effect
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
            );
          },
        ),
                      
                      ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(communityPostList.title,
                      style: titleStyle.copyWith(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(
                    communityPostList.content.length > 100
                        ? '${communityPostList.content.substring(0, 100)}...'
                        : communityPostList.content,
                    style: readingStyle, //2
                  ),
                  const Divider(
                    thickness: 0.9,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding: EdgeInsets.zero,
                    leading: UserProfilePic(
                      url: communityPostList.author.profilePic,
                    ),
                    title: Text(communityPostList.author.name,
                        style: bodyStyle),
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
      ),
    );
  }
}
