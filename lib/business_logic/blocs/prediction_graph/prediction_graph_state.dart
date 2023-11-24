part of 'prediction_graph_bloc.dart';

sealed class PredictionGraphState extends Equatable {
  const PredictionGraphState();

  @override
  List<Object> get props => [];
}

final class PredictionGraphInitial extends PredictionGraphState {}

final class PredictionGraphLoading extends PredictionGraphState {}

final class PredictionGraphLoaded extends PredictionGraphState {
  final PredictionModel predictionModel;
  const PredictionGraphLoaded({
    required this.predictionModel,
  });

  @override
  List<Object> get props => [predictionModel];
}

final class PredictionGraphError extends PredictionGraphState {
  final String message;
  const PredictionGraphError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
