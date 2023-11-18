import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/single_community_post.dart';

part 'single_community_post_event.dart';
part 'single_community_post_state.dart';

class SingleCommunityPostBloc
    extends Bloc<SingleCommunityPostEvent, SingleCommunityPostState> {
  SingleCommunityPostBloc(
      {required this.postId, required this.dio, required this.authToken})
      : super(SingleCommunityPostInitial()) {
    on<GetSingleCommunityPost>(_onGetSingleCommunityPost);
  }
  int postId;
  Dio dio;
  String authToken;

  void _onGetSingleCommunityPost(GetSingleCommunityPost event,
      Emitter<SingleCommunityPostState> emit) async {
    emit(SingleCommunityPostLoading());
    try {
      Response response = await dio.get(
        CommunityPostApiConstants.retrieveUpdateDestroy(postId),
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      SingleCommunityPost singleCommunityPost =
          SingleCommunityPost.fromJson(response.data);
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    } catch (e) {
      emit(SingleCommunityPostError(message: e.toString()));
    }
  }
}
