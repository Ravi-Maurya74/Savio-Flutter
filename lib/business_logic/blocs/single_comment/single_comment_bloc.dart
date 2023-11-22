import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/comment.dart';

part 'single_comment_event.dart';
part 'single_comment_state.dart';

class SingleCommentBloc extends Bloc<SingleCommentEvent, SingleCommentState> {
  SingleCommentBloc(
      {required Comment comment, required this.dio, required this.authToken})
      : super(SingleCommentState(comment: comment)) {
    on<AddLikeDislikeSingleCommentEvent>(_onAddLikeDislikeSingleComment);
    on<RemoveLikeDislikeSingleCommentEvent>(_onRemoveLikeDislikeSingleComment);
    on<ChangeLikeDislikeSingleCommentEvent>(_onChangeLikeDislikeSingleComment);
  }

  String authToken;
  Dio dio;

  void _onAddLikeDislikeSingleComment(AddLikeDislikeSingleCommentEvent event,
      Emitter<SingleCommentState> emit) async {
    Comment comment = (state).comment;
    emit(SingleCommentState(
        comment: comment.copyWith(
      vote: event.vote,
      score: comment.score + event.vote,
    )));

    try {
      dio.post(
        CommunityPostApiConstants.commentVote(comment.id),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommentState(comment: comment));
    }
  }

  void _onRemoveLikeDislikeSingleComment(
      RemoveLikeDislikeSingleCommentEvent event,
      Emitter<SingleCommentState> emit) async {
    Comment comment = (state).comment;
    emit(SingleCommentState(
        comment: comment.copyWith(
      vote: -5,
      score: comment.score - event.vote,
    )));

    try {
      dio.post(
        CommunityPostApiConstants.commentVote(comment.id),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommentState(comment: comment));
    }
  }

  void _onChangeLikeDislikeSingleComment(
      ChangeLikeDislikeSingleCommentEvent event,
      Emitter<SingleCommentState> emit) async {
    Comment comment = (state).comment;
    emit(SingleCommentState(
        comment: comment.copyWith(
      vote: event.vote,
      score: comment.score + 2 * event.vote,
    )));

    try {
      dio.post(
        CommunityPostApiConstants.commentVote(comment.id),
        data: {"vote": event.vote},
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
    } catch (e) {
      emit(SingleCommentState(comment: comment));
    }
  }
}
