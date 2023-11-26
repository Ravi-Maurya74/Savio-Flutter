part of 'clear_pending_registry_bloc.dart';

sealed class ClearPendingRegistryState extends Equatable {
  const ClearPendingRegistryState();
  
  @override
  List<Object> get props => [];
}

final class ClearPendingRegistryInitial extends ClearPendingRegistryState {}
