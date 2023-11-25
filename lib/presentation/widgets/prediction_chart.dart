import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
import 'package:savio/business_logic/blocs/auth/auth_cubit.dart';
import 'package:savio/business_logic/blocs/prediction_graph/prediction_graph_bloc.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/data/models/prediction_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PredictionDataWidget extends StatelessWidget {
  const PredictionDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (context, state) {
        if (state is PredictionGraphLoaded) {
          return PredictionWidget(state: state);
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
      bloc: PredictionGraphBloc(
          authToken: context.read<AuthCubit>().state.authToken!, dio: Dio()),
    );
  }
}

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    Key? key,
    required this.state,
  }) : super(key: key);
  final PredictionGraphLoaded state;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PredictionGraphWidget(
            predictionGraph: state.predictionModel.cumulative_expenditures,
            monthlyBudget: state.predictionModel.monthly_budget,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Predicted expenditure for this month: \$${state.predictionModel.predicted_total_expenditure}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'Your budget for this month: \$${state.predictionModel.monthly_budget}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            'You will be able to save: \$${((state.predictionModel.monthly_budget - state.predictionModel.predicted_total_expenditure)).toStringAsFixed(2)} if you spend according to your current expenditure pattern.',
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}

class PredictionGraphWidget extends StatefulWidget {
  const PredictionGraphWidget({
    Key? key,
    required this.predictionGraph,
    required this.monthlyBudget,
  }) : super(key: key);
  final List<PredictionData> predictionGraph;
  final double monthlyBudget;

  @override
  State<PredictionGraphWidget> createState() => _PredictionGraphWidgetState();
}

class _PredictionGraphWidgetState extends State<PredictionGraphWidget> {
  bool _showTrendline = false;
  bool _showBudgetBand = false;
  bool _showPredictedBand = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 350,
          child: SfCartesianChart(
            trackballBehavior: TrackballBehavior(
              enable: true,
              lineType: TrackballLineType.vertical,
              activationMode: ActivationMode.singleTap,
              tooltipSettings: const InteractiveTooltip(
                enable: true,
                color: Colors.blue,
                format: 'point.x : ₹point.y',
              ),
            ),
            title: ChartTitle(
              text: 'Predicted Expenditure',
              textStyle: titleStyle.copyWith(fontSize: 20),
            ),
            primaryXAxis: DateTimeAxis(
                desiredIntervals: 5,
                title: AxisTitle(
                  text: 'Days of the month',
                  textStyle: titleStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                labelStyle: titleStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.normal),
                plotBands: <PlotBand>[
                  PlotBand(
                    isVisible: _showPredictedBand,
                    start: DateTime.now(),
                    // end: DateTime.now().add(Duration(hours: 2)),
                    color: Colors.yellow,
                    text: 'Predicted Expenditure',
                    // verticalTextPadding: '-50%',
                    // horizontalTextPadding: '10%',
                    horizontalTextAlignment: TextAnchor.end,
                    verticalTextAlignment: TextAnchor.end,
                    opacity: 0.2,
                    textStyle: titleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    // shouldRenderAboveSeries: true,
                  ),
                ]),
            primaryYAxis: NumericAxis(
                // minimum: 0,
                // maximum: 10000,
                // interval: 1000,
                title: AxisTitle(
                  text: 'Expenditure',
                  textStyle: titleStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.normal),
                ),
                labelStyle: titleStyle.copyWith(
                    fontSize: 14, fontWeight: FontWeight.normal),
                plotBands: <PlotBand>[
                  PlotBand(
                    isVisible: _showBudgetBand,
                    // start: 0,
                    end: widget.monthlyBudget,
                    color: Colors.green,
                    text: 'Budget',
                    // verticalTextPadding: '-50%',
                    // horizontalTextPadding: '20%',
                    horizontalTextAlignment: TextAnchor.start,
                    verticalTextAlignment: TextAnchor.start,
                    opacity: 0.2,
                    textStyle: titleStyle.copyWith(
                        fontSize: 14, fontWeight: FontWeight.normal),
                    // shouldRenderAboveSeries: true,
                  ),
                ]),
            borderColor: Colors.white,

            // zoomPanBehavior: ZoomPanBehavior(
            //   enablePinching: true,
            //   // enablePanning: true,
            //   enableDoubleTapZooming: true,
            //   // enableSelectionZooming: true,
            //   enableMouseWheelZooming: true,
            // ),
            series: <ChartSeries>[
              LineSeries<PredictionData, DateTime>(
                dataSource: widget.predictionGraph,
                xValueMapper: (PredictionData predictionData, _) =>
                    DateTime.parse(predictionData.date),
                yValueMapper: (PredictionData predictionData, _) =>
                    predictionData.expenditure.floor(),
                name: 'Amount',
                // Enable data label
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: titleStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  labelAlignment: ChartDataLabelAlignment.top,
                  connectorLineSettings: const ConnectorLineSettings(
                      type: ConnectorType.line,
                      color: Colors.white,
                      width: 2,
                      length: '100%'),
                  // showZeroValue: false,
                  // labelPosition: ChartDataLabelPosition.outside
                ),
                enableTooltip: true,
                // markerSettings: const MarkerSettings(
                //   isVisible: true,
                // ),
                trendlines: <Trendline>[
                  if (_showTrendline)
                    Trendline(
                      // isVisible: _showTrendline,
                      type: TrendlineType.polynomial,
                      color: Colors.red,
                      width: 3,
                      enableTooltip: true,
                      dashArray: <double>[2, 3],
                      polynomialOrder: 3,
                      backwardForecast: 0,
                    )
                ],
              ),
            ],
          ),
        ),
        Wrap(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CheckboxListTile(
              title: Text(
                'Show Trendlines',
                style: titleStyle.copyWith(fontSize: 14),
              ),
              value: _showTrendline,
              onChanged: (bool? value) {
                setState(() {
                  _showTrendline = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text(
                'Show Budget Band',
                style: titleStyle.copyWith(fontSize: 14),
              ),
              value: _showBudgetBand,
              onChanged: (bool? value) {
                setState(() {
                  _showBudgetBand = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text(
                'Show Predicted Expenditure Band',
                style: titleStyle.copyWith(fontSize: 14),
              ),
              value: _showPredictedBand,
              onChanged: (bool? value) {
                setState(() {
                  _showPredictedBand = value!;
                });
              },
            ),
          ],
        ),
      ],
    );
  }
}
