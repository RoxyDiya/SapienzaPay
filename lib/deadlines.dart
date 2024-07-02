import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'detailspage.dart';
import 'utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 111, 20, 28),
      ),
      home: const HomePage(),
    );
  }
}

class DeadlinesPage extends StatefulWidget {
  const DeadlinesPage({super.key});

  @override
  _DeadlinesPageState createState() => _DeadlinesPageState();
}

class _DeadlinesPageState extends State<DeadlinesPage> {
  int _selectedIndex = 1;
  bool _isSelecting = false;
  Set<Map<String, String>> _selectedDeadlines = {};
  int? _selectedOption;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DeadlinesPage(),
    PlaceholderWidget('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> overdueFees = [
    {'month': 'NOV', 'day': '15', 'description': '1º TUITION FEE', 'amount': '€766'},
  ];

  final List<Map<String, String>> upcomingFees = [
    {'month': 'DEC', 'day': '19', 'description': '2º TUITION FEE', 'amount': '€670'},
    {'month': 'MAR', 'day': '10', 'description': '3º TUITION FEE', 'amount': '€805'}
  ];

  final List<Map<String, String>> paymentmeth = [
    {'icon': 'sapienzalogo.png', 'accname': 'University Bank Account'},
    {'icon': 'visalogo.png', 'accname': 'Card **** **** **** 9876'},
    {'icon': 'mclogo.png', 'accname': 'Card **** **** **** 1928'}
  ];

  void _onDeadlineTap(Map<String, String> deadline) {
    if (_isSelecting) {
      _toggleSelection(deadline);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeadlineDetailsPage(
            deadline: deadline //The argument type 'List<Map<String, String>> Function({bool growable})' can't be assigned to the parameter type 'List<Map<String, String>>'. 
          ),
        ),
      );
    }
  }

  void _onDeadlineLongPress(Map<String, String> deadline) {
    setState(() {
      _isSelecting = true;
      _selectedDeadlines.add(deadline);
    });
  }

  void _toggleSelection(Map<String, String> deadline) {
    setState(() {
      if (_selectedDeadlines.contains(deadline)) {
        _selectedDeadlines.remove(deadline);
        if (_selectedDeadlines.isEmpty) {
          _isSelecting = false;
        }
      } else {
        _selectedDeadlines.add(deadline);
      }
    });
  }

  void _cancelSelection() {
    setState(() {
      _isSelecting = false;
      _selectedDeadlines.clear();
    });
  }

  Widget buildPaymentMeth(Map<String, String> payment) {
    return GestureDetector(
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(payment['icon']!, width: 40, height: 40),
                const SizedBox(width: 10),
                Text(
                  payment['accname']!,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

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
              size: 40,
              _selectedOption == index
                  ? CupertinoIcons.check_mark_circled_solid
                  : CupertinoIcons.circle,
              color: _selectedOption == index
                  ? Color.fromARGB(255, 130, 36, 61)
                  : CupertinoColors.inactiveGray,
            ),
            //SizedBox(height: 1),
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

  Widget buildDeadlineItem(Map<String, String> deadline, bool isOverdue) {
    bool isSelected = _selectedDeadlines.contains(deadline);
    return Column(
      children: [
        Divider(color: CupertinoColors.inactiveGray.withOpacity(0.6), thickness: 0.5, height: 0.5),
        GestureDetector(
          onTap: () => _onDeadlineTap(deadline),
          onLongPress: () => _onDeadlineLongPress(deadline),
            child: Container(
              decoration: BoxDecoration(
              color: isOverdue 
                ? Color.fromARGB(33, 236, 51, 57)
                : Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isSelecting)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      isSelected
                        ? CupertinoIcons.check_mark_circled_solid
                        : CupertinoIcons.circle,
                      color: isSelected
                        ? Color.fromARGB(255, 130, 36, 61)
                        : CupertinoColors.inactiveGray,
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height:12),
                    Text(
                      deadline['month']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red[700],
                        fontSize: 16
                      ),
                    ),
                    Text(
                      deadline['day']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 40
                      ),
                    ),
                    SizedBox(height:8),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deadline['description']!,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(height:8),
                    Text(
                      deadline['amount']!,
                      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
                    ),
                  ],
                ),
                const Icon(CupertinoIcons.right_chevron),
              ],
            ),
          ),
        ),
        Divider(color: CupertinoColors.inactiveGray.withOpacity(0.6), thickness: 0.5, height: 0.5),
      ]
    );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only( top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60),
              const Text(
                ' Deadlines',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //might need to adjust width of main axis
                children: [
                  const Text(
                    '  Overdue:',
                    style: TextStyle(
                      color: Color.fromARGB(255, 111, 20, 28),
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),

                  if (_isSelecting)
                    GestureDetector(
                      onTap: _cancelSelection,
                      child: Text(
                        'Cancel  ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 130, 130, 146),
                          fontSize: 18
                        )
                      )
                    )//an object that responds to tap
                ],
              ),
              const SizedBox(height: 15),
              Column(
                children: overdueFees.map((fee) => buildDeadlineItem(fee, true)).toList(),
              ),
              const SizedBox(height: 40),
              const Text(
                '  Upcoming:',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 111, 20, 28),
                  fontWeight: FontWeight.normal,

                ),
              ),
              const SizedBox(height: 15),
              Column(
                children: upcomingFees.map((fee) => buildDeadlineItem(fee, false)).toList(),
              ),
              const SizedBox(height: 190),
              Center(
                child: ElevatedButton(
                  onPressed: _selectedDeadlines.isNotEmpty
                      ? () {
                          payModal(context);
                        }
                      : null,
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: Size.fromWidth(350),
                    backgroundColor: _selectedDeadlines.isNotEmpty
                        ? const Color.fromARGB(255, 111, 20, 28)
                        : Colors.grey[500],
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



/*code where I have made the page scrollable and added the list items
TODO: add these actions
- when clicking Pay, it should open a modal/page to select means of payment, then a riepilogo, then a done widget and navigation back to the deadlines page with the previously selected items removed + subtract money from the card in the home page + only allow the payment to happen if there is enough money + add the transaction to the list in the home page. 
*/