part of 'graph_bloc.dart';

sealed class GraphEvent extends Equatable {
  const GraphEvent();

  @override
  List<Object> get props => [];
}

final class GetGraphData extends GraphEvent {
  const GetGraphData();
}
