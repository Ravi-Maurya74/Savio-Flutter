import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/transaction.dart';

part 'single_transaction_state.dart';

class SingleTransactionCubit extends Cubit<SingleTransactionState> {
  SingleTransactionCubit({required this.dio, required this.authToken})
      : super(const SingleTransactionInitial());
  Dio dio;
  final String authToken;
  Future<bool> addNewTransaction(Map<String, dynamic> transaction) async {
    emit(const SingleTransactionLoading());
    try {
      final Response response = await dio.post(
        TransactionApiConstants.listCreate,
        data: FormData.fromMap(transaction),
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      final Transaction newTransaction = Transaction.fromMap(response.data);
      emit(SingleTransactionUpdated(transaction: newTransaction));
      return true;
    } on DioException catch (e) {
      // String temp = e.response!.data.toString();
      emit(SingleTransactionError(error: e.response!.data.toString()));
      return false;
    }
  }
}
