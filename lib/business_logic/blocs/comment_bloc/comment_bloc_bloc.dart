import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/comment.dart';

part 'comment_bloc_event.dart';
part 'comment_bloc_state.dart';

class CommentBloc extends Bloc<CommentBlocEvent, CommentBlocState> {
  CommentBloc(
      {required this.authToken,
      required this.dio,
      required this.postId,
      required this.commentId})
      : super(CommentBlocInitial()) {
    on<GetCommentBlocEvent>(_onGetCommentBloc);
    add(const GetCommentBlocEvent());
  }

  String authToken;
  int postId;
  Dio dio;
  int commentId;

  void _onGetCommentBloc(
      GetCommentBlocEvent event, Emitter<CommentBlocState> emit) async {
    emit(CommentBlocLoading());
    try {
      final response = await dio.post(
        CommunityPostApiConstants.comments,
        data: {
          'post_id': postId,
          'comment_id': commentId,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      List<Comment> commentList =
          (response.data as List).map((e) => Comment.fromMap(e)).toList();
      emit(CommentBlocLoaded(commentList: commentList));
    } catch (e) {
      emit(CommentBlocError(e.toString()));
    }
  }
}
