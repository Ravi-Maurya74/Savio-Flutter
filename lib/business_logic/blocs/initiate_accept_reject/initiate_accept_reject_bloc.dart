import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/data/models/initiate_peding_registry.dart';

part 'initiate_accept_reject_event.dart';
part 'initiate_accept_reject_state.dart';

class InitiateAcceptRejectBloc
    extends Bloc<InitiateAcceptRejectEvent, InitiateAcceptRejectState> {
  InitiateAcceptRejectBloc(
      {required this.authToken,
      required this.dio,
      required this.initiatePendingRegistry})
      : super(InitiateAcceptRejectInitial()) {
    on<InitiateAcceptRejectAccept>(_onAccept);
    on<InitiateAcceptRejectReject>(_onReject);
  }
  final String authToken;
  final Dio dio;
  final InitiatePendingRegistry initiatePendingRegistry;

  Future<void> _onAccept(InitiateAcceptRejectAccept event,
      Emitter<InitiateAcceptRejectState> emit) async {
    emit(InitiateAcceptRejectLoading());
    try {
      await dio.get(
        initiatePendingRegistry.accept_url.replaceAll('http:', 'https:'),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      event.onAccept();
      emit(InitiateAcceptRejectAccepted());
    } catch (e) {
      emit(InitiateAcceptRejectError(message: e.toString()));
    }
  }

  Future<void> _onReject(InitiateAcceptRejectReject event,
      Emitter<InitiateAcceptRejectState> emit) async {
    emit(InitiateAcceptRejectLoading());
    try {
      await dio.get(
        initiatePendingRegistry.reject_url.replaceAll('http:', 'https:'),
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      event.onReject();
      emit(InitiateAcceptRejectRejected());
    } catch (e) {
      emit(InitiateAcceptRejectError(message: e.toString()));
    }
  }
}
