import 'package:flutter/material.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/presentation/widgets/category_spending_chart.dart';
import 'package:savio/presentation/widgets/prediction_chart.dart';

class InsightTab extends StatelessWidget {
  const InsightTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Insights',style: titleStyle,),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            CategorySpendingChart(),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            PredictionDataWidget(),
          ],
        ),
      ),
    );
  }
}
