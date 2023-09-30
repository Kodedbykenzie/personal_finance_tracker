import 'package:flutter/material.dart';

class FinancialLiteracyPage extends StatelessWidget {
  const FinancialLiteracyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Financial Literacy Tips:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '1. Create a Budget: Learn how to budget your income and expenses.',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '2. Save Regularly: Understand the importance of saving for the future.',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '3. Invest Wisely: Explore different investment options and strategies.',
            style: TextStyle(fontSize: 16),
          ),
          Text(
            '4. Manage Debt: Learn how to handle and reduce debt responsibly.',
            style: TextStyle(fontSize: 16),
          ),
          // Add more financial literacy tips and information as needed
        ],
      ),
    );
  }
}
