import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/active_registry.dart';

part 'active_registry_event.dart';
part 'active_registry_state.dart';

class ActiveRegistryBloc
    extends Bloc<ActiveRegistryEvent, ActiveRegistryState> {
  ActiveRegistryBloc({required this.authToken, required this.dio})
      : super(ActiveRegistryInitial()) {
    on<FetchActiveRegistry>(_onFetchActiveRegistry);
    add(const FetchActiveRegistry());
  }
  final String authToken;
  final Dio dio;

  void _onFetchActiveRegistry(
      FetchActiveRegistry event, Emitter<ActiveRegistryState> emit) async {
    emit(ActiveRegistryLoading());
    try {
      final response = await dio.get(
        LendingRegistryApiConstants.active,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final List<ActiveRegistry> activeRegistries = (response.data as List)
          .map((e) => ActiveRegistry.fromMap(e))
          .toList();
      emit(ActiveRegistryLoaded(activeRegistries));
    } catch (e) {
      emit(ActiveRegistryError(e.toString()));
    }
  }
}
