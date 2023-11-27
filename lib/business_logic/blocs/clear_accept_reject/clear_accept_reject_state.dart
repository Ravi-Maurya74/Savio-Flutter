part of 'clear_accept_reject_bloc.dart';

sealed class ClearAcceptRejectState extends Equatable {
  const ClearAcceptRejectState();
  
  @override
  List<Object> get props => [];
}

final class ClearAcceptRejectInitial extends ClearAcceptRejectState {}

final class ClearAcceptRejectLoading extends ClearAcceptRejectState {}

final class ClearAcceptRejectCleared extends ClearAcceptRejectState {}

final class ClearAcceptRejectDenied extends ClearAcceptRejectState {}

final class ClearAcceptRejectError extends ClearAcceptRejectState {
  const ClearAcceptRejectError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

