import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';

part 'create_lending_registry_event.dart';
part 'create_lending_registry_state.dart';

class CreateLendingRegistryBloc
    extends Bloc<CreateLendingRegistryEvent, CreateLendingRegistryState> {
  CreateLendingRegistryBloc({required this.authToken, required this.dio})
      : super(CreateLendingRegistryInitial()) {
    on<CreateLendingRegistryEvent>(_createLendingRegistry);
  }
  final String authToken;
  final Dio dio;

  Future<void> _createLendingRegistry(CreateLendingRegistryEvent event,
      Emitter<CreateLendingRegistryState> emit) async {
    emit(CreateLendingRegistryLoading());
    try {
      final response = await dio.post(
        LendingRegistryApiConstants.create,
        data: {
          'lender': event.lender,
          'borrower': event.borrower,
          'amount': event.amount,
          'description': event.description,
        },
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      if (response.statusCode == 201) {
        emit(CreateLendingRegistryLoaded());
      } else {
        emit(const CreateLendingRegistryError('Something went wrong'));
      }
    } on DioException catch (e) {
      emit(CreateLendingRegistryError(e.response!.data['detail']));
    }
  }
}
