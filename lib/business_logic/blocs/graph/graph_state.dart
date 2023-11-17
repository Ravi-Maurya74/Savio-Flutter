part of 'graph_bloc.dart';

sealed class GraphState extends Equatable {
  const GraphState();

  @override
  List<Object> get props => [];
}

final class GraphInitial extends GraphState {}

final class GraphLoading extends GraphState {}

final class GraphLoaded extends GraphState {
  const GraphLoaded(this.chartData);

  final List<ChartData> chartData;

  @override
  List<Object> get props => [chartData];
}

final class GraphError extends GraphState {
  const GraphError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
