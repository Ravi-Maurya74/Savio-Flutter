part of 'initiate_accept_reject_bloc.dart';

sealed class InitiateAcceptRejectState extends Equatable {
  const InitiateAcceptRejectState();
  
  @override
  List<Object> get props => [];
}

final class InitiateAcceptRejectInitial extends InitiateAcceptRejectState {}

final class InitiateAcceptRejectLoading extends InitiateAcceptRejectState {}

final class InitiateAcceptRejectAccepted extends InitiateAcceptRejectState {}

final class InitiateAcceptRejectRejected extends InitiateAcceptRejectState {}

final class InitiateAcceptRejectError extends InitiateAcceptRejectState {
  const InitiateAcceptRejectError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
