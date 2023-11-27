import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/data/models/clear_pending_registry.dart';

part 'clear_accept_reject_event.dart';
part 'clear_accept_reject_state.dart';

class ClearAcceptRejectBloc
    extends Bloc<ClearAcceptRejectEvent, ClearAcceptRejectState> {
  ClearAcceptRejectBloc(
      {required this.authToken,
      required this.clearPendingRegistry,
      required this.dio})
      : super(ClearAcceptRejectInitial()) {
    on<ClearAcceptRejectClear>(_onClear);
    on<ClearAcceptRejectDeny>(_onDeny);
  }

  final String authToken;
  final Dio dio;
  final ClearPendingRegistry clearPendingRegistry;

  Future<void> _onClear(ClearAcceptRejectClear event,
      Emitter<ClearAcceptRejectState> emit) async {
    emit(ClearAcceptRejectLoading());
    try {
      await dio.get(
        clearPendingRegistry.accept_clear_request_url
            .replaceAll('http:', 'https:'),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      event.onClear();
      emit(ClearAcceptRejectCleared());
    } catch (e) {
      emit(ClearAcceptRejectError(message: e.toString()));
    }
  }

  Future<void> _onDeny(
      ClearAcceptRejectDeny event, Emitter<ClearAcceptRejectState> emit) async {
    emit(ClearAcceptRejectLoading());
    try {
      await dio.get(
        clearPendingRegistry.reject_clear_request_url
            .replaceAll('http:', 'https:'),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      event.onDeny();
      emit(ClearAcceptRejectDenied());
    } catch (e) {
      emit(ClearAcceptRejectError(message: e.toString()));
    }
  }
}
