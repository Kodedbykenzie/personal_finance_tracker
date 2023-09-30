import 'package:flutter/material.dart';

class BudgetsPage extends StatefulWidget {
  const BudgetsPage({super.key, required this.defaultBudgets});
  final Map<String, double> defaultBudgets;
  @override
  State<BudgetsPage> createState() => _BudgetStatePageState();
}

class _BudgetStatePageState extends State<BudgetsPage> {
  Map<String, double> budgets = {};

  @override
  void initState() {
    super.initState();
    budgets = widget.defaultBudgets;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Manage Budgets:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          for (String category in budgets.keys)
            BudgetItemRow(
              category: category,
              budget: budgets[category] ?? 0.0,
              onUpdateBudget: (double newBudget) {
                setState(() {
                  budgets[category] = newBudget;
                });
              },
            ),
        ],
      ),
    );
  }
}

class BudgetItemRow extends StatelessWidget {
  final String category;
  final double budget;
  final ValueChanged<double> onUpdateBudget;

  const BudgetItemRow({
    super.key,
    required this.category,
    required this.budget,
    required this.onUpdateBudget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(category, style: const TextStyle(fontSize: 16)),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: budget.toStringAsFixed(2),
              decoration: const InputDecoration(
                labelText: 'Budget',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double newBudget = double.tryParse(value) ?? 0.0;
                onUpdateBudget(newBudget);
              },
            ),
          ),
        ],
      ),
    );
  }
}
