import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:savio/data/models/active_registry.dart';

part 'clear_registry_request_event.dart';
part 'clear_registry_request_state.dart';

class ClearRegistryRequestBloc
    extends Bloc<ClearRegistryRequestEvent, ClearRegistryRequestState> {
  ClearRegistryRequestBloc(
      {required this.activeRegistry,
      required this.authToken,
      required this.dio})
      : super(ClearRegistryRequestInitial()) {
    on<ClearRegistryRequestEvent>(_onClearRegistryRequestEvent);
  }
  final String authToken;
  final Dio dio;
  final ActiveRegistry activeRegistry;

  Future<void> _onClearRegistryRequestEvent(
    ClearRegistryRequestEvent event,
    Emitter<ClearRegistryRequestState> emit,
  ) async {
    emit(ClearRegistryRequestLoading());
    try {
      // var temp = authToken;
      final response = await dio.get(
        activeRegistry.initiate_clearing_request_url.replaceAll('http:', 'https:'),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      emit(const ClearRegistryRequestLoaded());
      event.onClearRegistryRequestEvent();
    } on DioException catch (e) {
      emit(ClearRegistryRequestError(e.toString()));
    }
  }
}
