import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/graph/graph_bloc.dart';
import 'package:savio/data/models/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphCarousel extends StatelessWidget {
  const GraphCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 10,
        itemBuilder: (context, index, realIndex) {
          return getSinlgeGraphGenerator(realIndex - 10000);
        },
        options: CarouselOptions(
          height: 250,
          enlargeCenterPage: true,
        ));
  }

  SingleGraphGenerator getSinlgeGraphGenerator(int monthOffset) {
    DateTime now = DateTime.now();
    int year = now.year;
    int month = now.month;

    DateTime dateTime = DateTime(year, month + monthOffset);

    year = dateTime.year;
    month = dateTime.month;

    return SingleGraphGenerator(year: year, month: month);
  }
}

class SingleGraphGenerator extends StatelessWidget {
  const SingleGraphGenerator(
      {super.key, required this.year, required this.month});
  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GraphBloc, GraphState>(
      bloc: GraphBloc(
          authToken: context.read<AuthCubit>().state.authToken!,
          dio: Dio(),
          month: month,
          year: year),
      builder: (context, state) {
        if (state is GraphLoaded) {
          return GraphWidget(chartData: state.chartData,month: month,year: year,);
        } else if (state is GraphError) {
          return Center(child: Text(state.message));
        } else {
          return GraphWidget(chartData: const [],month: month,year: year,);
        }
      },
    );
  }
}

class GraphWidget extends StatelessWidget {
  const GraphWidget({super.key, required this.chartData,required this.month,required this.year});

  final List<ChartData> chartData;
  final int year;
  final int month;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 0, top: 1),
      padding: const EdgeInsets.only(top: 6, right: 4, left: 2),
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF50559a).withOpacity(0.4),
              const Color.fromARGB(255, 240, 139, 171).withOpacity(0.3),

              //50559a
            ]),
        boxShadow: const [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 1),
            // color: Color.fromARGB(255, 194, 194, 194),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 2, 4),
        child: SfCartesianChart(
          primaryXAxis: DateTimeAxis(),
          title: ChartTitle(
            text: DateFormat("MMMM yyyy").format(DateTime(year, month)),
            textStyle: Theme.of(context).textTheme.bodySmall,
          ),
          // enableAxisAnimation: true,
          tooltipBehavior: TooltipBehavior(
            builder: (data, point, series, pointIndex, seriesIndex) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${DateFormat("d MMM").format(DateTime.parse((data).date))}: ₹${data.total_amount.toString()}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              );
            },
            enable: true,
          ),
          isTransposed: true,
          series: <ChartSeries>[
            BarSeries<ChartData, DateTime>(
              isVisibleInLegend: true,
              color:
                  const Color.fromARGB(255, 110, 152, 174).withOpacity(0.8), //
              dataSource: chartData,
              xValueMapper: (data, _) => DateTime.parse(data.date),
              yValueMapper: (data, _) => data.total_amount,
            ),
          ],
        ),
      ),
    );
  }
}
