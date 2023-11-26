import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/user.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserBloc({required this.authToken, required this.dio})
      : super(SearchUserInitial()) {
    on<SearchUserEvent>(_onSearchUserEvent);
  }
  final String authToken;
  final Dio dio;

  Future<void> _onSearchUserEvent(
      SearchUserEvent event, Emitter<SearchUserState> emit) async {
    emit(SearchUserLoading());
    try {
      final response = await dio.get(
        UserApiConstants.search,
        queryParameters: {
          'search': event.query,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final List<User> users =
          (response.data as List<dynamic>).map((e) => User.fromMap(e)).toList();
      emit(SearchUserLoaded(users));
    } catch (e) {
      emit(SearchUserError(e.toString()));
    }
  }
}
