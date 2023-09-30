import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SpendingData {
  final String category;
  final double amount;

  SpendingData(this.category, this.amount);
}

final List<SpendingData> spendingData = [
  SpendingData('Food', 500.0),
  SpendingData('Housing', 1000.0),
  SpendingData('Utilities', 200.0),
  SpendingData('Miscellaneous', 100.0),
];

class ReportAnalysisPage extends StatelessWidget {
  const ReportAnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a series with your spending data
    final series = [
      charts.Series(
        id: 'Spending',
        data: spendingData,
        domainFn: (SpendingData data, _) => data.category,
        measureFn: (SpendingData data, _) => data.amount,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Expenses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: charts.BarChart(
              series,
              animate: true, // You can enable animation if desired
            ),
          ),
        ],
      ),
    );
  }
}
