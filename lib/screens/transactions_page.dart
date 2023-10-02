import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  String selectedCategory = 'Food'; // Default category
  TextEditingController amountController = TextEditingController();

  // List to store user transactions
  List<TransactionItem> transactions = [];

  // Budget data
  Map<String, double> budgets = {
    'Food': 500.0,
    'Housing': 1000.0,
    'Utilities': 200.0,
    'Miscellaneous': 100.0,
  };

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double remainingBudget = calculateRemainingBudget();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: selectedCategory,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedCategory = newValue;
                });
              }
            },
            items: budgets.keys.map((String category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category, style: const TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
          TextFormField(
            controller: amountController,
            decoration: const InputDecoration(
              labelText: 'Amount',
            ),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              double amount = double.tryParse(amountController.text) ?? 0.0;
              if (amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Invalid amount.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
                return;
              }

              TransactionItem newTransaction = TransactionItem(
                category: selectedCategory,
                amount: amount,
              );
              transactions.add(newTransaction);

              amountController.clear();

              setState(() {});
            },
            child: const Text(
              'Add Transaction',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Transactions:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: transactions.isEmpty
                ? const Center(
                    child: Text('No transactions yet.',
                        style: TextStyle(fontSize: 16)))
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      TransactionItem transaction = transactions[index];
                      return ListTile(
                        title: Text('Category: ${transaction.category}',
                            style: const TextStyle(fontSize: 16)),
                        subtitle: Text(
                            'Amount: \$${transaction.amount.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16)),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 20),
          Text(
            'Remaining Budget: \$${remainingBudget.toStringAsFixed(2)}',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  double calculateRemainingBudget() {
    double totalBudget = budgets.values.reduce((a, b) => a + b);
    double totalSpent =
        transactions.map((t) => t.amount).fold(0, (a, b) => a + b);
    return totalBudget - totalSpent;
  }
}

class TransactionItem {
  final String category;
  final double amount;

  TransactionItem({
    required this.category,
    required this.amount,
  });
}
