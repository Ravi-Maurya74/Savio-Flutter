part of 'create_lending_registry_bloc.dart';

sealed class CreateLendingRegistryState extends Equatable {
  const CreateLendingRegistryState();
  
  @override
  List<Object> get props => [];
}

final class CreateLendingRegistryInitial extends CreateLendingRegistryState {}

final class CreateLendingRegistryLoading extends CreateLendingRegistryState {}

final class CreateLendingRegistryLoaded extends CreateLendingRegistryState {}

final class CreateLendingRegistryError extends CreateLendingRegistryState {
  final String message;

  const CreateLendingRegistryError(this.message);

  @override
  List<Object> get props => [message];
}
