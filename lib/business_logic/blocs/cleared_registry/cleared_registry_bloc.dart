import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/cleared_registry.dart';

part 'cleared_registry_event.dart';
part 'cleared_registry_state.dart';

class ClearedRegistryBloc
    extends Bloc<ClearedRegistryEvent, ClearedRegistryState> {
  ClearedRegistryBloc({required this.authToken, required this.dio})
      : super(ClearedRegistryInitial()) {
    on<ClearedRegistryEvent>(_onClearedRegistryEvent);
    add(const ClearedRegistryEvent());
  }

  final String authToken;
  final Dio dio;

  void _onClearedRegistryEvent(
      ClearedRegistryEvent event, Emitter<ClearedRegistryState> emit) async {
    emit(ClearedRegistryLoading());
    try {
      final response = await dio.get(
        LendingRegistryApiConstants.cleared,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final List<ClearedRegistry> clearedRegistryList = (response.data as List)
          .map((e) => ClearedRegistry.fromMap(e))
          .toList();
      emit(ClearedRegistryLoaded(clearedRegistryList: clearedRegistryList));
    } catch (e) {
      emit(ClearedRegistryError(message: e.toString()));
    }
  }
}
