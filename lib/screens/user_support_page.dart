import 'package:flutter/material.dart';

class UserSupportPage extends StatelessWidget {
  const UserSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            FaqItem(
              question: 'How do I create a budget?',
              answer:
                  'To create a budget, go to the Budgets page and click the "+" button to add budget categories and set budget amounts.',
            ),
            FaqItem(
              question: 'Can I edit or delete a transaction?',
              answer:
                  'Yes, you can edit or delete a transaction. Go to the Transactions page, find the transaction, and click the "Edit" or "Delete" button.',
            ),
            FaqItem(
              question: 'How can I view my spending report?',
              answer:
                  'You can view your spending report on the Report & Analysis page. It provides visual charts and data about your expenses.',
            ),
            // Add more FAQs as needed
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatelessWidget {
  final String question;
  final String answer;

  const FaqItem({super.key, required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontSize: 16),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer, style: const TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}
