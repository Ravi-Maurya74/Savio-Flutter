import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';

part 'comment_create_event.dart';
part 'comment_create_state.dart';

class CommentCreateBloc extends Bloc<CommentCreateEvent, CommentCreateState> {
  CommentCreateBloc(
      {required this.authToken,
      required this.dio,
      required this.postId,
      required this.commentId})
      : super(CommentCreateInitial()) {
    on<CommentCreateEvent>(_onCommentCreate);
  }

  String authToken;
  Dio dio;
  int postId;
  int commentId;

  void _onCommentCreate(
      CommentCreateEvent event, Emitter<CommentCreateState> emit) async {
    emit(CommentCreateLoading());
    try {
      await dio.post(
        CommunityPostApiConstants.commentCreate,
        data: {
          "post_id": postId,
          "comment_id": commentId,
          "content": event.content,
        },
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      emit(const CommentCreateLoaded());
      event.onCommentCreate();
    } catch (e) {
      emit(CommentCreateError(message: e.toString()));
    }
  }
}
