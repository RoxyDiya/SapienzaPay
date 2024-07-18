import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'all_in_one_deadline.dart';
import 'deadline_parent.dart';
import 'deadlines.dart';
import 'detailspage.dart';
import 'detailspage2.dart';
import 'detailspage3.dart';
import 'profile_par.dart';
import 'utils.dart';
import 'deadline_parent.dart';
import 'detailspageALL.dart';
import 'home_page.dart';
import 'login.dart';

class TransactionsProvider extends ChangeNotifier {
  double balance = 2500.00;
  bool _showUniversityTransactions = false;
  
  List<Map<String, String>> _universityTransactions = [
    {
      'title': 'University Fee',
      'amount': '€300.00',
      'date': '12 March 2023',
    },
    {
      'title': 'Library Fee',
      'amount': '€50.00',
      'date': '15 March 2023',
    },
    {
      'title': 'University Fee',
      'amount': '€300.00',
      'date': '12 March 2023',
    },
    {
      'title': 'Library Fee',
      'amount': '€50.00',
      'date': '15 March 2023',
    },
    {
      'title': 'University Fee',
      'amount': '€300.00',
      'date': '12 March 2023',
    },
    {
      'title': 'Library Fee',
      'amount': '€50.00',
      'date': '15 March 2023',
    },
    {
      'title': 'University Fee',
      'amount': '€300.00',
      'date': '12 March 2023',
    },
    {
      'title': 'Library Fee',
      'amount': '€50.00',
      'date': '15 March 2023',
    },
    {
      'title': 'University Fee',
      'amount': '€300.00',
      'date': '12 March 2023',
    },
    {
      'title': 'Library Fee',
      'amount': '€50.00',
      'date': '15 March 2023',
    },// Your predefined transactions here
  ];

  List<Map<String, String>> _allTransactions = [
    {
      'title': 'Grocery',
      'amount': '€50.00',
      'date': '10 March 2023',
    },
    {
      'title': 'Cinema',
      'amount': '€15.00',
      'date': '11 March 2023',
    },
    // Your predefined transactions here
  ];

  bool get showUniversityTransactions => _showUniversityTransactions;
  List<Map<String, String>> get universityTransactions => _universityTransactions;
  List<Map<String, String>> get allTransactions => _allTransactions;

  void subtractUniversityTransaction(String title, String amount, DateTime date) {
    double transactionAmount = double.parse(amount.replaceAll('€', ''));
    balance -= transactionAmount;
    
    Map<String, String> newTransaction = {
      'title': title,
      'amount': '-€${transactionAmount.toStringAsFixed(2)}',
      'date': DateFormat('d MMMM yyyy').format(date),
    };

    universityTransactions.insert(0, newTransaction); // Insert at the beginning
    notifyListeners();
  }

  void toggleShowUniversityTransactions(bool show) {
    _showUniversityTransactions = show;
    notifyListeners();
  }

  void addUniversityTransaction(String title, String amount, DateTime date) {
    Map<String, String> newTransaction = {
      'title': title,
      'amount': amount,
      'date': DateFormat('d MMMM yyyy').format(date),
    };
    _universityTransactions.insert(0, newTransaction); // Insert at the beginning
    _allTransactions.insert(0, newTransaction); // Insert at the beginning for all transactions as well
    notifyListeners();
  }
}
