import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:savio/constants/constant.dart';
import 'package:savio/data/models/chart_data.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc({required this.authToken, required this.dio,required this.month,required this.year})
      : super(GraphInitial()) {
    on<GetGraphData>(_onGetGraphData);
    add(const GetGraphData());
  }
  Dio dio;
  String authToken;
  int month;
  int year;
  FutureOr<void> _onGetGraphData(
      GetGraphData event, Emitter<GraphState> emit) async {
    emit(GraphLoading());
    try {
      final response = await dio.get(
        '${TransactionApiConstants.baseUrl}daily/$year/$month/',
        options: Options(headers: {
          'Authorization': 'Token $authToken',
        }),
      );
      List<ChartData> chartData =
          (response.data as List).map((e) => ChartData.fromMap(e)).toList();
      emit(GraphLoaded(chartData));
    } catch (e) {
      emit(GraphError(e.toString()));
    }
  }
}
