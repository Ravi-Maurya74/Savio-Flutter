import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required this.authToken, required this.dio})
      : super(const InitialUserState()) {
    on<GetInitialUserData>(_onGetInitialUserData);
    on<UserUpdate>(_onUserUpdate);
  }

  final String authToken;
  final Dio dio;

  FutureOr<void> _onGetInitialUserData(
      GetInitialUserData event, Emitter<UserState> emit) async {
    // emit(state.copyWith(status: UserStatus.loading));
    try {
      final response = await dio.get(UserApiConstants.me,
          options: Options(headers: {
            'Authorization': 'Token $authToken',
          }));
      final user = User.fromMap(response.data);
      emit(LoadedUserState(user: user));
    } on DioException catch (e) {
      print(e.toString());
      emit(ErrorUserState(error: e.response?.data['message']));
    }
  }

  Future<FutureOr<void>> _onUserUpdate(
      UserUpdate event, Emitter<UserState> emit) async {
    emit(LoadingUserState(user: state.user));
    Map<String,dynamic> data = Map<String, dynamic>.from(event.jsonMap);
    // data.remove('profile_pic');
    if (event.jsonMap.containsKey('profile_pic')) {
      data['profile_pic'] = event.jsonMap['profile_pic']!=null? await MultipartFile.fromFile(
        event.jsonMap['profile_pic'].path,
      ):null;
    }
    try {
      final response = await dio.patch(
        UserApiConstants.me,
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
        data: FormData.fromMap(data),
      );
      User newUser = User.fromMap(response.data);
      emit(LoadedUserState(user: newUser));
    } on DioException catch (e) {
      print(e.toString());
      emit(state.copyWith(
          status: UserStatus.error, error: e.response?.data['message']));
    }
  }
}
