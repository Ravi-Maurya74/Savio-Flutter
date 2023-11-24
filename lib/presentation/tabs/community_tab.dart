import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/CommunityPostList/community_post_list_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/community_post_list.dart';
import 'package:savio/presentation/screens/add_community_post_screen.dart';
import 'package:savio/presentation/widgets/community_post_card.dart';

class CommunityTab extends StatelessWidget {
  const CommunityTab(
      {super.key, this.myPosts = false, this.savedPosts = false});
  final bool savedPosts;
  final bool myPosts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: myPosts==false && savedPosts==false? OpenContainer(
        transitionDuration: const Duration(milliseconds: 500),
        transitionType: ContainerTransitionType.fadeThrough,
        closedShape: const CircleBorder(),
        closedColor: const Color(0xFF50559a),
        openColor: Theme.of(context)
            .scaffoldBackgroundColor, //const Color(0xFF16161e),
        middleColor: const Color(0xFFd988a1),
        closedBuilder: (context, action) => Container(
          margin: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Color(0xFF50559a),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
            color: Color.fromARGB(255, 216, 216, 216),
          ),
        ),
        openBuilder: (context, action) => const AddCommunityPostScreen(),
      ):null,
      appBar: AppBar(
        title: Text(
          myPosts
              ? 'My Posts'
              : savedPosts
                  ? 'Saved Posts'
                  : 'Community',
          style: titleStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<CommunityPostListBloc>().add(
                    GetCommunityPostListEvent(),
                  );
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<CommunityPostListBloc, CommunityPostListState>(
          builder: (context, state) {
            if (state is CommunityPostListLoaded) {
              return CommunityTabListWidget(
                communityPostList: state.communityPostList,
              );
            } else if (state is CommunityPostListError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
          // bloc: CommunityPostListBloc(
          //   authToken: context.read<AuthCubit>().state.authToken!,
          //   dio: Dio(),
          // ),
        ),
      ),
    );
  }
}

class CommunityTabListWidget extends StatelessWidget {
  const CommunityTabListWidget({super.key, required this.communityPostList});
  final List<CommunityPostList> communityPostList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return CommunityPostCard(
                communityPostList: communityPostList[index]);
          },
          itemCount: communityPostList.length,
        )),
      ],
    );
  }
}
