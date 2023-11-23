import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/category_spending/category_spending_bloc.dart';
import 'package:savio/data/models/category_spending.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class CategorySpendingChart extends StatelessWidget {
  const CategorySpendingChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is CategorySpendingLoaded) {
          return CategorySpendingGraphWidget(
            categorySpending: state.categorySpending,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      bloc: CategorySpendingBloc(
          authToken: context.read<AuthCubit>().state.authToken!,
          dio: Dio(),
          month: DateTime.now().month,
          year: DateTime.now().year),
    );
  }
}

class CategorySpendingGraphWidget extends StatelessWidget {
  const CategorySpendingGraphWidget(
      {super.key, required this.categorySpending});
  final List<CategorySpending> categorySpending;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: SfCircularChart(
        legend: const Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
        ),
        title: ChartTitle(
          text: 'Category Spending',
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltipBehavior: TooltipBehavior(
          builder: (data, point, series, pointIndex, seriesIndex){
            return Container(
              color: Colors.white,
              child: Text(
                '${data.category__name} : ${data.total_spending}',
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
        ),
        series: <CircularSeries>[
          DoughnutSeries<CategorySpending, String>(
            dataSource: categorySpending,
            xValueMapper: (CategorySpending data, _) => data.category__name,
            yValueMapper: (CategorySpending data, _) => data.total_spending,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
            ),
          ),
        ],
      ),
    );
  }
}
