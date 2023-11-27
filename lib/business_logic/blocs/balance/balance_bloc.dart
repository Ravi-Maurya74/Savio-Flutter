import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';

part 'balance_event.dart';
part 'balance_state.dart';

class BalanceBloc extends Bloc<BalanceEvent, BalanceState> {
  BalanceBloc({required this.authToken, required this.dio})
      : super(BalanceInitial()) {
    on<BalanceEvent>(_onBalanceEvent);
    add(const BalanceEvent());
  }
  final String authToken;
  final Dio dio;

  void _onBalanceEvent(BalanceEvent event, Emitter<BalanceState> emit) async {
    emit(BalanceLoading());
    try {
      final response = await dio.get(
        LendingRegistryApiConstants.balance,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      emit(BalanceLoaded(
          total_lent: response.data['total_lent'].toDouble(),
          total_owed: response.data['total_owed'].toDouble(),
          net: response.data['net'].toDouble()));
    } catch (e) {
      emit(BalanceError(message: e.toString()));
    }
  }
}
