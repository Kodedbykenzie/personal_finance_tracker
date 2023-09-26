import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      fontFamily: 'Roboto',
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    TransactionsPage(),
    BudgetsPage(defaultBudgets: {
      'Food': 500.0,
      'Housing': 1000.0,
      'Utilities': 200.0,
      'Miscellaneous': 100.0,
    }),
    ReportAnalysisPage(),
    UserSupportPage(), // Only one instance of UserSupportPage
  ];

  final List<String> _pageTitles = [
    'Transactions',
    'Budgets',
    'Report & Analysis',
    'User Support and FAQs', // Updated page title
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _showLogoutConfirmation(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Log Out Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(fontSize: 16, color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pageTitles[_selectedIndex],
          style: TextStyle(fontSize: 24),
        ),
        actions: _selectedIndex == 3
            ? [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _showLogoutConfirmation(context);
            },
          ),
        ]
            : null,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Budgets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Report & Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.question_answer), // Changed icon to a question mark
            label: 'User Support and FAQs', // Updated label
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onTabTapped,
      ),
    );
  }
}

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
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
                child: Text(category, style: TextStyle(fontSize: 16)),
              );
            }).toList(),
          ),
          TextFormField(
            controller: amountController,
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
            keyboardType: TextInputType.number,
          ),
          ElevatedButton(
            onPressed: () {
              double amount = double.tryParse(amountController.text) ?? 0.0;
              if (amount <= 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
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
            child: Text(
              'Add Transaction',
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Transactions:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: transactions.isEmpty
                ? Center(child: Text('No transactions yet.', style: TextStyle(fontSize: 16)))
                : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                TransactionItem transaction = transactions[index];
                return ListTile(
                  title: Text('Category: ${transaction.category}', style: TextStyle(fontSize: 16)),
                  subtitle: Text('Amount: \$${transaction.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
                );
              },
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Remaining Budget: \$${remainingBudget.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  double calculateRemainingBudget() {
    double totalBudget = budgets.values.reduce((a, b) => a + b);
    double totalSpent = transactions.map((t) => t.amount).fold(0, (a, b) => a + b);
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

class BudgetsPage extends StatefulWidget {
  final Map<String, double> defaultBudgets;

  BudgetsPage({required this.defaultBudgets});

  @override
  _BudgetsPageState createState() => _BudgetsPageState();
}

class _BudgetsPageState extends State<BudgetsPage> {
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
          Text('Manage Budgets:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
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

  BudgetItemRow({
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
            child: Text(category, style: TextStyle(fontSize: 16)),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: TextFormField(
              initialValue: budget.toStringAsFixed(2),
              decoration: InputDecoration(
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
          Text(
            'Expenses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
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

class FinancialLiteracyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

// User Support and FAQs Page
class UserSupportPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10),
            FaqItem(
              question: 'How do I create a budget?',
              answer: 'To create a budget, go to the Budgets page and click the "+" button to add budget categories and set budget amounts.',
            ),
            FaqItem(
              question: 'Can I edit or delete a transaction?',
              answer: 'Yes, you can edit or delete a transaction. Go to the Transactions page, find the transaction, and click the "Edit" or "Delete" button.',
            ),
            FaqItem(
              question: 'How can I view my spending report?',
              answer: 'You can view your spending report on the Report & Analysis page. It provides visual charts and data about your expenses.',
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

  FaqItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(fontSize: 16),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer, style: TextStyle(fontSize: 14)),
        ),
      ],
    );
  }
}



