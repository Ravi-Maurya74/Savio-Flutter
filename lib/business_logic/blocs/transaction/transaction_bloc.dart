import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc({required this.authToken, required this.dio})
      : super(TransactionInitialState()) {
    on<FetchAllTransactionsEvent>(_onFetchAllTransactionsEvent);
  }

  final String authToken;
  final Dio dio;

  FutureOr<void> _onFetchAllTransactionsEvent(
      FetchAllTransactionsEvent event, Emitter<TransactionState> emit) async {
    emit(LoadingAllTransactionsState());
    try {
      final response = await dio.get(
        TransactionApiConstants.listCreate,
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      final transactions = (response.data as List)
          .map((e) => Transaction.fromMap(e))
          .toList();
      emit(AllTransactionsLoadedState(transactions: transactions));
    } on DioException catch (e) {
      // print(e.toString());
      emit(ErrorAllTransactionsState(error: e.response?.data['message']));
    }
  }
}
