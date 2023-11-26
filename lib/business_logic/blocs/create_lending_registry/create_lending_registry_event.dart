part of 'create_lending_registry_bloc.dart';

final class CreateLendingRegistryEvent extends Equatable {
  const CreateLendingRegistryEvent({required this.lender, required this.borrower, required this.amount, required this.description});

  final int lender;
  final int borrower;
  final String amount;
  final String description;

  @override
  List<Object> get props => [lender, borrower, amount, description];
}
