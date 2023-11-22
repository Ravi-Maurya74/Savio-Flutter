import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';

part 'create_community_post_event.dart';
part 'create_community_post_state.dart';

class CreateCommunityPostBloc
    extends Bloc<CreateCommunityPostEvent, CreateCommunityPostState> {
  CreateCommunityPostBloc({required this.authToken, required this.dio})
      : super(CreateCommunityPostInitial()) {
    on<CreateCommunityPostEvent>(_onCreateCommunityPostEvent);
  }
  final String authToken;
  final Dio dio;

  void _onCreateCommunityPostEvent(CreateCommunityPostEvent event,
      Emitter<CreateCommunityPostState> emit) async {
    emit(CreateCommunityPostLoading());
    try {
      final formData = FormData.fromMap({
        'title': event.title,
        'content': event.content,
        'image': event.image != null
            ? await MultipartFile.fromFile(event.image!.path)
            : null,
      });
      final response = await dio.post(
        CommunityPostApiConstants.baseUrl,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      if (response.statusCode == 201) {
        emit(const CreateCommunityPostLoaded());
      } else {
        emit(const CreateCommunityPostError(
            message: 'Something went wrong. Please try again later.'));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        emit(CreateCommunityPostError(message: e.response!.data['message']));
      } else {
        emit(const CreateCommunityPostError(
            message: 'Something went wrong. Please try again later.'));
      }
    } catch (e) {
      emit(const CreateCommunityPostError(
          message: 'Something went wrong. Please try again later.'));
    }
  }
}
