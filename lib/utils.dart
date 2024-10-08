import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'deadlines.dart';
import 'home_page.dart' as home_page;
import 'package:intl/intl.dart';
import 'transactions_provider.dart';



// VARS
int? _selectedOption;
double balance = 2500.00;
double firstInst = 766.00;
double secondInst = 670.00;
double thirdInst = 805.00;

// LISTS
List<Map<String, String>> overdueFees = [
  {'month': 'NOV', 'day': '15', 'description': '1st TUITION FEE', 'amount': '€766'},
];

List<Map<String, String>> upcomingFees = [
  {'month': 'DEC', 'day': '19', 'description': '2nd TUITION FEE', 'amount': '€670'},
  {'month': 'MAR', 'day': '10', 'description': '3rd TUITION FEE', 'amount': '€805'}
];

List<Map<String, String>> allinonefees = [
  {'month': 'NOV', 'day': '15', 'description': 'TUITION FEE', 'amount': '€2209'},
];

bool isPaymentCompleted = false;

void updatePaymentStatus() {
  isPaymentCompleted = true;
}


void showPayModal(BuildContext context, Set<Map<String, String>> selectedDeadlines, VoidCallback onPaymentSuccess) {
  double totalAmount = selectedDeadlines.fold(0.0, (sum, deadline) {
    return sum + double.parse(deadline['amount']!.replaceAll('€', '').trim());
  });
  print('Selected Deadlines" $selectedDeadlines');

  print ('Total Amount: $totalAmount');
  
  double newBalance = balance - totalAmount;
  if (_selectedOption != null && _selectedOption! == 3) {
  home_page.updateBalance(newBalance);
  }
  print('Balance: $balance');
  print('New Balance: $newBalance');
  String selectedFeeDescription = selectedDeadlines.map((d) => d['description']!.split(' ').take(1).join()).join(' & ') + ' Tuition Fee';
  
  showCupertinoModalPopup(
    context: context,
    builder: (BuildContext context) => CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Payment Method'),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: PayModalContent(
        totalAmount: totalAmount,
        selectedFeeDescription: selectedFeeDescription,
        onPaymentSuccess: onPaymentSuccess,
      ),
    ),
  );
}


class PayModalContent extends StatefulWidget {
  final double totalAmount;
  final String selectedFeeDescription;
  final VoidCallback onPaymentSuccess;

  PayModalContent({
    required this.totalAmount,
    required this.selectedFeeDescription,
    required this.onPaymentSuccess,
  });

  @override
  PayModalContentState createState() => PayModalContentState();
}


class PayModalContentState extends State<PayModalContent> {
  int? _selectedOption;
  OverlayEntry? _overlayEntry;

  OverlayEntry _createOverlayEntry(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.22,
        right: -30,
        child: GestureDetector(
          onTap: () {
            _navigateToPaymentMethod(context);
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Double Click \n to Pay',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              SizedBox(width: 5),
              Container(
                width: 40,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CupertinoColors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void _removeOverlayEntry() {
    if (_overlayEntry != null) {
      _overlayEntry!.remove();
      _overlayEntry = null;
    }
  }

  void _navigateToPaymentMethod(BuildContext context) {
    if (!mounted) {
      print('Error: Widget is not mounted');
      return;
    }
    try {
      _removeOverlayEntry();
      print('Overlay entry removed.');

      if (Navigator.canPop(context)) {
        Navigator.of(context).pop();
        print('Payment confirmation modal popped.');
      }

      // Call the function to update the payment status
      updatePaymentStatus();

      // Call subtractUniversityTransaction to update the balance and fee list
      if (_selectedOption != null && _selectedOption! == 3) {
      home_page.subtractUniversityTransaction(
        title: widget.selectedFeeDescription,
        amount: widget.totalAmount.toStringAsFixed(2),
        date: DateTime.now(), // Example date, adjust as needed
        setStateCallback: setState, // Assuming you have access to setState
        universityTransactions: home_page.universityTransactions, // Assuming this list is accessible
        allTransactions: home_page.allTransactions, // Assuming this list is accessible
        balance: home_page.balance, // Assuming this variable is accessible
    );}

      widget.onPaymentSuccess();
    } catch (e) {
      print('Error in _navigateToPaymentMethod: $e');
    }
  }

  void _showPaymentConfirmationModal(BuildContext context) {
    if (_selectedOption == null) return;

    String selectedPaymentMethod = _paymentMethods[_selectedOption!];

    _overlayEntry = _createOverlayEntry(context);
    Overlay.of(context)!.insert(_overlayEntry!);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext modalContext, StateSetter setModalState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Transaction recap',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _navigateToPaymentMethod(context);
                        },
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Icon(
                              CupertinoIcons.circle_fill,
                              size: 30,
                              color: CupertinoColors.systemGrey5,
                            ),
                            Icon(
                              CupertinoIcons.xmark,
                              size: 18,
                              color: CupertinoColors.systemGrey,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.only(left: 12.0, right: 60, top: 12.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      color: CupertinoColors.systemGrey6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bank Account',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          selectedPaymentMethod,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.only(left: 12.0, right: 60, top: 12.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      color: CupertinoColors.systemGrey6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To:',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'University of Rome "La Sapienza" \n IBAN: IT71I0200805227000400014148',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.95,
                    padding: EdgeInsets.only(left: 12.0, right: 60, top: 12.0, bottom: 12.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 1.0,
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      color: CupertinoColors.systemGrey6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Invoice to:',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Firdaous Hajjaji \nLargo Itri 25, Roma \nhajjaji.2006406@studenti.uniroma1.it',
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Total:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${widget.totalAmount.toStringAsFixed(2)} €',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Divider(
                    color: CupertinoColors.systemGrey4,
                    thickness: 0.5,
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/sidebutton.png',
                          width: 60,
                          height: 60,
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Confirm with Side Button',
                          style: TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).whenComplete(() {
      _overlayEntry?.remove();
      setState(() {
        _selectedOption = null;
      });
    });
  }

  Widget _buildOptionRow(int index, String text) {
    String imagePath = 'assets/card${index + 1}.png';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedOption = index;
        });
        _showPaymentConfirmationModal(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CupertinoColors.systemGrey4,
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
            Image.asset(
              imagePath,
              width: 50,
              height: 30,
            ),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final List<String> _paymentMethods = [
    'Card **** **** **** 1928',
    'Card **** **** **** 5678',
    'Card **** **** **** 0886',
    'University Bank Account',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 90),
          Column(
            children: List.generate(_paymentMethods.length, (index) {
              return _buildOptionRow(index, _paymentMethods[index]);
            }),
          ),
        ],
      ),
    );
  }
}

