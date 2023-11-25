part of 'clear_registry_request_bloc.dart';

sealed class ClearRegistryRequestState extends Equatable {
  const ClearRegistryRequestState();
  
  @override
  List<Object> get props => [];
}

final class ClearRegistryRequestInitial extends ClearRegistryRequestState {}

final class ClearRegistryRequestLoading extends ClearRegistryRequestState {}

final class ClearRegistryRequestLoaded extends ClearRegistryRequestState {

  const ClearRegistryRequestLoaded();
}

final class ClearRegistryRequestError extends ClearRegistryRequestState {
  final String message;

  const ClearRegistryRequestError(this.message);

  @override
  List<Object> get props => [message];
}
