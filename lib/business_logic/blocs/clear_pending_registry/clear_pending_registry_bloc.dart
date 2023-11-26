import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/clear_pending_registry.dart';

part 'clear_pending_registry_event.dart';
part 'clear_pending_registry_state.dart';

class ClearPendingRegistryBloc
    extends Bloc<ClearPendingRegistryEvent, ClearPendingRegistryState> {
  ClearPendingRegistryBloc({required this.authToken, required this.dio})
      : super(ClearPendingRegistryInitial()) {
    on<ClearPendingRegistryEvent>(_onClearPendingRegistryEvent);
    add(const ClearPendingRegistryEvent());
  }

  final String authToken;
  final Dio dio;

  void _onClearPendingRegistryEvent(ClearPendingRegistryEvent event,
      Emitter<ClearPendingRegistryState> emit) async {
    emit(ClearPendingRegistryLoading());
    try {
      final response = await dio.get(
        LendingRegistryApiConstants.clearRequestPending,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final clearPendingRegistries = (response.data as List)
          .map((e) => ClearPendingRegistry.fromMap(e))
          .toList();
      emit(ClearPendingRegistryLoaded(
          clearPendingRegistryList: clearPendingRegistries));
    } catch (e) {
      emit(ClearPendingRegistryError(message: e.toString()));
    }
  }
}
