part of 'prediction_graph_bloc.dart';

sealed class PredictionGraphEvent extends Equatable {
  const PredictionGraphEvent();

  @override
  List<Object> get props => [];
}

final class PredictionGraphLoad extends PredictionGraphEvent {
  const PredictionGraphLoad();
}
