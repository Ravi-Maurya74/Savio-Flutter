import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/category_spending/category_spending_bloc.dart';
import 'package:savio/constants/decorations.dart';
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
      height: 400,
      child: SfCircularChart(
        legend: Legend(
          isVisible: true,
          overflowMode: LegendItemOverflowMode.wrap,
          position: LegendPosition.bottom,
          textStyle:
              titleStyle.copyWith(fontSize: 14, fontWeight: FontWeight.normal),
        ),
        title: ChartTitle(
          text: 'Category Spending',
          textStyle: titleStyle.copyWith(fontSize: 20),
        ),
        tooltipBehavior: TooltipBehavior(
            enable: true,
            builder: (dynamic data, dynamic point, dynamic series,
                int pointIndex, int seriesIndex) {
              return Material(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${data.category__name} : ₹${data.total_spending}',
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }),
        series: <CircularSeries>[
          DoughnutSeries<CategorySpending, String>(
            dataSource: categorySpending,
            xValueMapper: (CategorySpending data, _) => data.category__name,
            yValueMapper: (CategorySpending data, _) => data.total_spending,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              textStyle: titleStyle.copyWith(
                  fontSize: 14, fontWeight: FontWeight.normal),
              useSeriesColor: true,
              // builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
              //   return Text(
              //     '${data.total_spending}',
              //     style: const TextStyle(
              //       // color: Colors.black,
              //     ),
              //   );
              // }
            ),
          ),
        ],
      ),
    );
  }
}
