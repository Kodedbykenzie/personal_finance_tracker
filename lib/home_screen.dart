import 'package:flutter/material.dart';
import 'package:personal_finance_tracker/screens/budget_page.dart';

import 'package:personal_finance_tracker/screens/report_analysis_parge.dart';
import 'package:personal_finance_tracker/screens/transactions_page.dart';
import 'package:personal_finance_tracker/screens/user_support_page.dart';

void main() {
  runApp(MaterialApp(
    home: const HomePage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      fontFamily: 'Roboto',
    ),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const TransactionsPage(),
    const BudgetsPage(defaultBudgets: {
      'Food': 500.0,
      'Housing': 1000.0,
      'Utilities': 200.0,
      'Miscellaneous': 100.0,
    }),
    const ReportAnalysisPage(),
    const UserSupportPage(), // Only one instance of UserSupportPage
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
          title: const Text(
            'Log Out Confirmation',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          content: const Text(
            'Are you sure you want to log out?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'No',
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
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
          style: const TextStyle(fontSize: 24),
        ),
        actions: _selectedIndex == 3
            ? [
                IconButton(
                  icon: const Icon(Icons.logout),
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
            icon:
                Icon(Icons.question_answer), // Changed icon to a question mark
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
