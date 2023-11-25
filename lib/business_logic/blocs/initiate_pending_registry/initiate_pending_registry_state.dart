part of 'initiate_pending_registry_bloc.dart';

sealed class InitiatePendingRegistryState extends Equatable {
  const InitiatePendingRegistryState();

  @override
  List<Object> get props => [];
}

final class InitiatePendingRegistryInitial
    extends InitiatePendingRegistryState {}

final class InitiatePendingRegistryLoading
    extends InitiatePendingRegistryState {}

final class InitiatePendingRegistryLoaded extends InitiatePendingRegistryState {
  final List<InitiatePendingRegistry> initiatePendingRegistries;

  const InitiatePendingRegistryLoaded(
      {required this.initiatePendingRegistries});
}

final class InitiatePendingRegistryError extends InitiatePendingRegistryState {
  final String message;

  const InitiatePendingRegistryError(this.message);

  @override
  List<Object> get props => [message];
}
