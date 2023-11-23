import 'package:flutter/material.dart';
import 'package:savio/presentation/widgets/category_spending_chart.dart';

class InsightTab extends StatelessWidget {
  const InsightTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Insights'),
      ),
      body: const Column(
        children: [
          CategorySpendingChart(),
        ],
      ),
    );
  }
}

