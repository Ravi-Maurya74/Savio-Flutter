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
    on<GetSingleCommunityPostEvent>(_onGetSingleCommunityPost);
    on<TestEvent>(
        (TestEvent event, Emitter<SingleCommunityPostState> emit) async {
      // print("BookMarked");
      emit(SingleCommunityPostLoaded(
          singleCommunityPost: (state as SingleCommunityPostLoaded)
              .singleCommunityPost
              .copyWith(is_bookmarked: true, title: "new Title")));
    });
    // on<UpdateSingleCommunityPost>(_onUpdateSingleCommunityPost);
    on<BookMarkSingleCommunityPostEvent>(_onBookMarkSingleCommunityPost);
    on<AddLikeDislikeSingleCommunityPostEvent>(
        _onAddLikeDislikeSingleCommunityPost);
    on<RemoveLikeDislikeSingleCommunityPostEvent>(
        _onRemoveLikeDislikeSingleCommunityPost);
    on<ChangeLikeDislikeSingleCommunityPostEvent>(_onChangeLikeDislikeSingleCommunityPost);
    add(const GetSingleCommunityPostEvent());
  }
  int postId;
  Dio dio;
  String authToken;

  void _onGetSingleCommunityPost(GetSingleCommunityPostEvent event,
      Emitter<SingleCommunityPostState> emit) async {
    emit(SingleCommunityPostLoading());
    // await Future.delayed(const Duration(seconds: 5));
    try {
      Response response = await dio.get(
        CommunityPostApiConstants.retrieveUpdateDestroy(postId),
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      SingleCommunityPost singleCommunityPost =
          SingleCommunityPost.fromMap(response.data);
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    } catch (e) {
      emit(SingleCommunityPostError(message: e.toString()));
    }
  }

  void _onBookMarkSingleCommunityPost(BookMarkSingleCommunityPostEvent event,
      Emitter<SingleCommunityPostState> emit) async {
    SingleCommunityPost singleCommunityPost =
        (state as SingleCommunityPostLoaded).singleCommunityPost;
    emit(SingleCommunityPostLoaded(
        singleCommunityPost: singleCommunityPost.copyWith(
            is_bookmarked: !singleCommunityPost.is_bookmarked)));
    // await Future.delayed(const Duration(seconds: 5));
    try {
      dio.post(
        CommunityPostApiConstants.bookmark(postId),
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    }
  }

  void _onAddLikeDislikeSingleCommunityPost(
      AddLikeDislikeSingleCommunityPostEvent event,
      Emitter<SingleCommunityPostState> emit) async {
    SingleCommunityPost singleCommunityPost =
        (state as SingleCommunityPostLoaded).singleCommunityPost;
    emit(SingleCommunityPostLoaded(
        singleCommunityPost: singleCommunityPost.copyWith(
      score: singleCommunityPost.score + event.vote,
      vote: event.vote,
    )));
    // await Future.delayed(const Duration(seconds: 5));
    try {
      dio.post(
        CommunityPostApiConstants.vote(postId),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    }
  }

  void _onRemoveLikeDislikeSingleCommunityPost(
      RemoveLikeDislikeSingleCommunityPostEvent event,
      Emitter<SingleCommunityPostState> emit) async {
    SingleCommunityPost singleCommunityPost =
        (state as SingleCommunityPostLoaded).singleCommunityPost;
    emit(SingleCommunityPostLoaded(
        singleCommunityPost: singleCommunityPost.copyWith(
      score: singleCommunityPost.score - event.vote,
      vote: -5,
    )));
    // await Future.delayed(const Duration(seconds: 5));
    try {
      dio.post(
        CommunityPostApiConstants.vote(postId),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    }
  }

  void _onChangeLikeDislikeSingleCommunityPost(
      ChangeLikeDislikeSingleCommunityPostEvent event,
      Emitter<SingleCommunityPostState> emit) async {
    SingleCommunityPost singleCommunityPost =
        (state as SingleCommunityPostLoaded).singleCommunityPost;
    emit(SingleCommunityPostLoaded(
        singleCommunityPost: singleCommunityPost.copyWith(
      score: singleCommunityPost.score + 2*event.vote,
      vote: event.vote,
    )));
    // await Future.delayed(const Duration(seconds: 5));
    try {
      dio.post(
        CommunityPostApiConstants.vote(postId),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommunityPostLoaded(singleCommunityPost: singleCommunityPost));
    }
  }
}
