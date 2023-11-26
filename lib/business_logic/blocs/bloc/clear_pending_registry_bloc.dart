import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clear_pending_registry_event.dart';
part 'clear_pending_registry_state.dart';

class ClearPendingRegistryBloc extends Bloc<ClearPendingRegistryEvent, ClearPendingRegistryState> {
  ClearPendingRegistryBloc() : super(ClearPendingRegistryInitial()) {
    on<ClearPendingRegistryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
