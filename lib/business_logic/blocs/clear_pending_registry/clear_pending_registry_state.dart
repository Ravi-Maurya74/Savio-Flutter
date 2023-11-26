part of 'clear_pending_registry_bloc.dart';

sealed class ClearPendingRegistryState extends Equatable {
  const ClearPendingRegistryState();
  
  @override
  List<Object> get props => [];
}

final class ClearPendingRegistryInitial extends ClearPendingRegistryState {}

final class ClearPendingRegistryLoading extends ClearPendingRegistryState {}

final class ClearPendingRegistryLoaded extends ClearPendingRegistryState {
  final List<ClearPendingRegistry> clearPendingRegistryList;

  const ClearPendingRegistryLoaded({required this.clearPendingRegistryList});

  @override
  List<Object> get props => [clearPendingRegistryList];
}

final class ClearPendingRegistryError extends ClearPendingRegistryState {
  final String message;

  const ClearPendingRegistryError({required this.message});

  @override
  List<Object> get props => [message];
}
