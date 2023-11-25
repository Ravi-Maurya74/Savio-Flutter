import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/initiate_peding_registry.dart';

part 'initiate_pending_registry_event.dart';
part 'initiate_pending_registry_state.dart';

class InitiatePendingRegistryBloc
    extends Bloc<InitiatePendingRegistryEvent, InitiatePendingRegistryState> {
  InitiatePendingRegistryBloc({required this.authToken, required this.dio})
      : super(InitiatePendingRegistryInitial()) {
    on<InitiatePendingRegistryEvent>(_onInitiatePendingRegistryEvent);
    add(const InitiatePendingRegistryEvent());
  }
  final String authToken;
  final Dio dio;

  Future<void> _onInitiatePendingRegistryEvent(
    InitiatePendingRegistryEvent event,
    Emitter<InitiatePendingRegistryState> emit,
  ) async {
    emit(InitiatePendingRegistryLoading());
    try {
      final response = await dio.get(
        LendingRegistryApiConstants.initiateRequestPending,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final initiatePendingRegistries = (response.data as List)
          .map((e) => InitiatePendingRegistry.fromMap(e))
          .toList();
      emit(InitiatePendingRegistryLoaded(
          initiatePendingRegistries: initiatePendingRegistries));
      // event.onInitiatePendingRegistryEvent();
    } on DioException catch (e) {
      emit(InitiatePendingRegistryError(e.toString()));
    }
  }
}
