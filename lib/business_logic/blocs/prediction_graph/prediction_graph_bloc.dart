import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/prediction_data.dart';

part 'prediction_graph_event.dart';
part 'prediction_graph_state.dart';

class PredictionGraphBloc
    extends Bloc<PredictionGraphEvent, PredictionGraphState> {
  PredictionGraphBloc({required this.authToken, required this.dio})
      : super(PredictionGraphInitial()) {
    on<PredictionGraphLoad>(_onPredictionGraphLoad);
    add(const PredictionGraphLoad());
  }
  final String authToken;
  final Dio dio;

  Future<void> _onPredictionGraphLoad(
      PredictionGraphLoad event, Emitter<PredictionGraphState> emit) async {
    emit(PredictionGraphLoading());
    try {
      final response = await dio.get(
        TransactionApiConstants.prediction,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
          },
        ),
      );
      final PredictionModel predictionModel =
          PredictionModel.fromMap(response.data);
      emit(PredictionGraphLoaded(predictionModel: predictionModel));
    } on DioException catch (e) {
      emit(PredictionGraphError(message: e.message.toString()));
    }
  }
}
