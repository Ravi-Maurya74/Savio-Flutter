part of 'clear_registry_request_bloc.dart';

final class ClearRegistryRequestEvent extends Equatable {
  const ClearRegistryRequestEvent({required this.onClearRegistryRequestEvent});
  final VoidCallback onClearRegistryRequestEvent;

  @override
  List<Object> get props => [];
}


