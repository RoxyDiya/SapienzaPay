import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

//VARS
int? _selectedOption;
double balance = 2500.00;
double firstInst = 766.00;
double secondInst = 670.00;
double thirdInst = 805.00;

//LISTS
List<Map<String, String>> overdueFees = [
  {'month': 'NOV', 'day': '15', 'description': '1st TUITION FEE', 'amount': '€766'},
];

List<Map<String, String>> upcomingFees = [
  {'month': 'DEC', 'day': '19', 'description': '2nd TUITION FEE', 'amount': '€670'},
  {'month': 'MAR', 'day': '10', 'description': '3rd TUITION FEE', 'amount': '€805'}
];

List<Map<String, String>> paymentmeth = [
  {'icon': 'sapienzalogo.png', 'accname': 'University Bank Account'},
  {'icon': 'visalogo.png', 'accname': 'Card **** **** **** 9876'},
  {'icon': 'mclogo.png', 'accname': 'Card **** **** **** 1928'}
];

Set<Map<String, String>> selectedDeadlines = {};

List<Map<String, String>> universityTransactions = [
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
];

List<Map<String, String>> allTransactions = [
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
];

//FUNCS
void payModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: CupertinoColors.inactiveGray,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      'Payment Method',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: paymentmeth.map((payment) {
                    int index = paymentmeth.indexOf(payment);
                    return buildOptionRow(index, payment['accname']!, setState, context);
                  }).toList(),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void addUniversityTransaction(String title, String amount, DateTime date) {
  Map<String, String> newTransaction = {
    'title': title,
    'amount': amount,
    'date': DateFormat('d MMMM yyyy').format(date),
  };
  universityTransactions.insert(0, newTransaction); // Insert at the beginning
  allTransactions.insert(0, newTransaction); // Insert at the beginning for all transactions as well
}

Widget buildOptionRow(int index, String text, StateSetter setState, BuildContext context) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedOption = index;
      });
      // Show the payment confirmation modal
      showPaymentConfirmationModal(context);
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color.fromARGB(255, 209, 209, 214),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _selectedOption == index
                ? CupertinoIcons.check_mark_circled_solid
                : CupertinoIcons.circle,
            color: _selectedOption == index
                ? Color.fromARGB(255, 130, 36, 61)
                : CupertinoColors.inactiveGray,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    ),
  );
}

void showPaymentConfirmationModal(BuildContext context) {
  if (_selectedOption == null) return;

  // Get the selected payment method
  String selectedPaymentMethod = paymentmeth[_selectedOption!]['accname']!;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: CupertinoColors.inactiveGray,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Text(
                      'Confirm Payment',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'You have selected:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  selectedPaymentMethod,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Overdue Fee:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${overdueFees[0]['description']} - ${overdueFees[0]['amount']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      processPayment(context, overdueFees[0]);
                    },
                    child: Text('Confirm Payment'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

void processPayment(BuildContext context, Map<String, String> fee) {
  double feeAmount = double.parse(fee['amount']!.replaceAll('€', ''));

  if (balance >= feeAmount) {
    balance -= feeAmount;
    addUniversityTransaction(fee['description']!, fee['amount']!, DateTime.now());

    // Remove the fee from overdue fees
    overdueFees.remove(fee);

    // Close the modal
    Navigator.pop(context);
    Navigator.pop(context);
  } else {
    // Show an error if the balance is not sufficient
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Insufficient Balance'),
          content: Text('Your balance is not sufficient to make this payment.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}