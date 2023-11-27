part of 'cleared_registry_bloc.dart';

sealed class ClearedRegistryState extends Equatable {
  const ClearedRegistryState();

  @override
  List<Object> get props => [];
}

final class ClearedRegistryInitial extends ClearedRegistryState {}

final class ClearedRegistryLoading extends ClearedRegistryState {}

final class ClearedRegistryLoaded extends ClearedRegistryState {
  final List<ClearedRegistry> clearedRegistryList;

  const ClearedRegistryLoaded({
    required this.clearedRegistryList,
  });

  @override
  List<Object> get props => [clearedRegistryList];
}

final class ClearedRegistryError extends ClearedRegistryState {
  final String message;

  const ClearedRegistryError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
