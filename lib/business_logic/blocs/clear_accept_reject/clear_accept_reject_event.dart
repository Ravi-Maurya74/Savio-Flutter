part of 'clear_accept_reject_bloc.dart';

sealed class ClearAcceptRejectEvent extends Equatable {
  const ClearAcceptRejectEvent();

  @override
  List<Object> get props => [];
}

final class ClearAcceptRejectClear extends ClearAcceptRejectEvent {
  const ClearAcceptRejectClear({required this.onClear});
  final VoidCallback onClear;
}

final class ClearAcceptRejectDeny extends ClearAcceptRejectEvent {
  const ClearAcceptRejectDeny({required this.onDeny});
  final VoidCallback onDeny;
}
