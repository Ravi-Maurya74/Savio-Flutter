part of 'active_registry_bloc.dart';

sealed class ActiveRegistryState extends Equatable {
  const ActiveRegistryState();
  
  @override
  List<Object> get props => [];
}

final class ActiveRegistryInitial extends ActiveRegistryState {}

final class ActiveRegistryLoading extends ActiveRegistryState {}

final class ActiveRegistryLoaded extends ActiveRegistryState {
  final List<ActiveRegistry> activeRegistries ;

  const ActiveRegistryLoaded(this.activeRegistries);

  @override
  List<Object> get props => [activeRegistries];
}

final class ActiveRegistryError extends ActiveRegistryState {
  final String message;

  const ActiveRegistryError(this.message);

  @override
  List<Object> get props => [message];
}