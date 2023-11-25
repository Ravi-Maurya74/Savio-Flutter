part of 'initiate_accept_reject_bloc.dart';

sealed class InitiateAcceptRejectEvent extends Equatable {
  const InitiateAcceptRejectEvent();

  @override
  List<Object> get props => [];
}

final class InitiateAcceptRejectAccept extends InitiateAcceptRejectEvent {
  const InitiateAcceptRejectAccept({required this.onAccept});
  final VoidCallback onAccept;
}

final class InitiateAcceptRejectReject extends InitiateAcceptRejectEvent {
  const InitiateAcceptRejectReject({required this.onReject});
  final VoidCallback onReject;
}
