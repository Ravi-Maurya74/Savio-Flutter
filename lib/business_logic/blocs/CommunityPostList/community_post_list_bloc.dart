import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/community_post_list.dart';

part 'community_post_list_event.dart';
part 'community_post_list_state.dart';

class CommunityPostListBloc
    extends Bloc<CommunityPostListEvent, CommunityPostListState> {
  CommunityPostListBloc({required this.authToken, required this.dio,this.savedPosts=false,this.myPosts=false})
      : super(CommunityPostListInitial()) {
    on<GetCommunityPostListEvent>(_onGetCommunityPostListEvent);
    add(GetCommunityPostListEvent());
  }
  Dio dio;
  String authToken;
  final bool savedPosts;
  final bool myPosts;

  FutureOr<void> _onGetCommunityPostListEvent(GetCommunityPostListEvent event,
      Emitter<CommunityPostListState> emit) async {
    emit(CommunityPostListLoading());
    try {
      final response = await dio.get(
        savedPosts?CommunityPostApiConstants.bookmarked:myPosts?CommunityPostApiConstants.userPosts:
        CommunityPostApiConstants.listCreate,
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      List<CommunityPostList> communityPostList = (response.data as List)
          .map((e) => CommunityPostList.fromMap(e))
          .toList();
      emit(CommunityPostListLoaded(communityPostList));
    } catch (e) {
      emit(CommunityPostListError(e.toString()));
    }
  }
}
