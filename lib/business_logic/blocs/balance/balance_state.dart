part of 'balance_bloc.dart';

sealed class BalanceState extends Equatable {
  const BalanceState();

  @override
  List<Object> get props => [];
}

final class BalanceInitial extends BalanceState {}

final class BalanceLoading extends BalanceState {}

final class BalanceLoaded extends BalanceState {
  const BalanceLoaded(
      {required this.total_lent, required this.total_owed, required this.net});
  final double total_owed;
  final double total_lent;
  final double net;

  @override
  List<Object> get props => [total_owed, total_lent, net];
}

final class BalanceError extends BalanceState {
  const BalanceError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
