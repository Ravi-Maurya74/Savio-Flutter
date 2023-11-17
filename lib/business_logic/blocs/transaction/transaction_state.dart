part of 'transaction_bloc.dart';

sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

final class TransactionInitialState extends TransactionState {}

final class ErrorAllTransactionsState extends TransactionState {
  final String? error;
  const ErrorAllTransactionsState({this.error});

  @override
  List<Object> get props => [error??''];
}

final class LoadingAllTransactionsState extends TransactionState {}

final class AllTransactionsLoadedState extends TransactionState {
  final List<Transaction> transactions;
  const AllTransactionsLoadedState({required this.transactions});

  @override
  List<Object> get props => [transactions];
}
