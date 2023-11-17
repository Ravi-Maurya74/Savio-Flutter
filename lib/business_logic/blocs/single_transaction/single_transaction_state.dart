part of 'single_transaction_cubit.dart';

sealed class SingleTransactionState extends Equatable {
  const SingleTransactionState({required this.transaction});
  final Transaction? transaction;

  @override
  List<Object> get props => [];
}

final class SingleTransactionInitial extends SingleTransactionState {
  const SingleTransactionInitial({Transaction? transaction})
      : super(transaction: transaction);
}

final class SingleTransactionLoading extends SingleTransactionState {
  const SingleTransactionLoading() : super(transaction: null);
}

final class SingleTransactionUpdated extends SingleTransactionState {
  const SingleTransactionUpdated({required Transaction transaction})
      : super(transaction: transaction);
}

final class SingleTransactionError extends SingleTransactionState {
  final String error;
  const SingleTransactionError({required this.error})
      : super(transaction: null);
}