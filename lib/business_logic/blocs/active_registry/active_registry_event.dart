part of 'active_registry_bloc.dart';

sealed class ActiveRegistryEvent extends Equatable {
  const ActiveRegistryEvent();

  @override
  List<Object> get props => [];
}

final class FetchActiveRegistry extends ActiveRegistryEvent {
  const FetchActiveRegistry();
}