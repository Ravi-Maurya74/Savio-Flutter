import 'package:flutter/material.dart';
import 'package:savio/constants/decorations.dart';
import 'package:savio/presentation/widgets/category_spending_chart.dart';
import 'package:savio/presentation/widgets/prediction_chart.dart';

class InsightTab extends StatefulWidget {
  const InsightTab({super.key});

  @override
  State<InsightTab> createState() => _InsightTabState();
}

class _InsightTabState extends State<InsightTab> {
  Key key1 = UniqueKey();
  Key key2 = UniqueKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text('Insights',style: titleStyle,),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                key1 = UniqueKey();
                key2 = UniqueKey();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            CategorySpendingChart(
              key: key1,
            ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            PredictionDataWidget(
              key: key2,
            ),
          ],
        ),
      ),
    );
  }
}
