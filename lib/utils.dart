import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//VARS
int? _selectedOption;

//LISTS
final List<Map<String, String>> overdueFees = [
  {'month': 'NOV', 'day': '15', 'description': '1st TUITION FEE', 'amount': '€766'},
];

final List<Map<String, String>> upcomingFees = [
  {'month': 'DEC', 'day': '19', 'description': '2nd TUITION FEE', 'amount': '€670'},
  {'month': 'MAR', 'day': '10', 'description': '3rd TUITION FEE', 'amount': '€805'}
];

final List<Map<String, String>> paymentmeth = [
  {'icon': 'sapienzalogo.png', 'accname': 'University Bank Account'},
  {'icon': 'visalogo.png', 'accname': 'Card **** **** **** 9876'},
  {'icon': 'mclogo.png', 'accname': 'Card **** **** **** 1928'}
];

Set<Map<String, String>> selectedDeadlines = {};



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
                    return buildOptionRow(index, payment['accname']!, setState);
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

Widget buildOptionRow(int index, String text, StateSetter setState) {
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedOption = index;
      });
      //second modal
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