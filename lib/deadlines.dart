import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'detailspage.dart' as detailspage1;
import 'detailspage2.dart' as detailspage2;
import 'detailspage3.dart' as detailspage3;
import 'utils.dart';
import 'profile_stud.dart';

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
  double _totalAmount = 0.0;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DeadlinesPage(),
    ProfileScreen(),  // Replace with the correct ProfileScreen if it conflicts
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

void _onDeadlineTap(Map<String, String> deadline) {
  if (_isSelecting) {
    _toggleSelection(deadline);
  } else {
    Widget detailsPage;
    String description = deadline['description'] ?? '';

    switch (description) {
      case '1st TUITION FEE':
        detailsPage = detailspage1.DeadlineDetailsPage(
          deadline: deadline,
          showPayModal: showPayModal,
          removeSelectedDeadline: _removeSelectedDeadlines
        );
        break;
      case '2nd TUITION FEE':
        detailsPage = detailspage2.DeadlineDetailsPage(
          deadline: deadline,
          //showPayModal: showPayModal,
          //removeSelectedDeadline: _removeSelectedDeadlines
        );
        break;
      case '3rd TUITION FEE':
        detailsPage = detailspage3.DeadlineDetailsPage(
          deadline: deadline,
          //showPayModal: showPayModal,
          //removeSelectedDeadline: _removeSelectedDeadlines
        );
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      CupertinoPageRoute(builder: (context) => detailsPage),
    );
  }
}


  void _onDeadlineLongPress(Map<String, String> deadline) {
    setState(() {
      _isSelecting = true;
      _selectedDeadlines.add(deadline);
      _updateTotalAmount();
    });
  }

  void _toggleSelection(Map<String, String> deadline) {
    setState(() {
      if (_selectedDeadlines.contains(deadline)) {
        _selectedDeadlines.remove(deadline);
      } else {
        _selectedDeadlines.add(deadline);
      }
      _updateTotalAmount();

      if (_selectedDeadlines.isEmpty) {
        _isSelecting = false;
      }
    });
  }

  void _updateTotalAmount() {
    _totalAmount = _selectedDeadlines.fold(0.0, (sum, deadline) {
      return sum + double.parse(deadline['amount']!.replaceAll('€', '').trim());
    });
  }

  void _cancelSelection() {
    setState(() {
      _isSelecting = false;
      _selectedDeadlines.clear();
      _totalAmount = 0.0;
    });
  }

  Widget buildDeadlineItem(Map<String, String> deadline, bool isOverdue, int index) {
    bool isSelected = _selectedDeadlines.contains(deadline);
    return Column(
      key: ValueKey(index),  // Ensure each item has a unique key
      children: [
        Divider(
          color: CupertinoColors.inactiveGray.withOpacity(0.6),
          thickness: 0.5,
          height: 0.5,
        ),
        GestureDetector(
          onTap: () => _onDeadlineTap(deadline),
          onLongPress: () => _onDeadlineLongPress(deadline),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: isOverdue ? Color.fromARGB(33, 236, 51, 57) : Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_isSelecting)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Icon(
                      isSelected
                          ? CupertinoIcons.check_mark_circled_solid
                          : CupertinoIcons.circle,
                      color: isSelected
                          ? Color.fromARGB(255, 130, 36, 61)
                          : CupertinoColors.inactiveGray,
                      size: 30,
                    ),
                  ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12),
                    Text(
                      deadline['month']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.red[700],
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      deadline['day']!,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deadline['description']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      deadline['amount']!,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 28),
                    ),
                  ],
                ),
                Spacer(),
                if (!_isSelecting)
                  const Icon(CupertinoIcons.right_chevron),
              ],
            ),
          ),
        ),
        Divider(
          color: CupertinoColors.inactiveGray.withOpacity(0.6),
          thickness: 0.5,
          height: 0.5,
        ),
      ],
    );
  }

  void _removeSelectedDeadlines() {
    setState(() {
      overdueFees.removeWhere((fee) => _selectedDeadlines.contains(fee));
      upcomingFees.removeWhere((fee) => _selectedDeadlines.contains(fee));
      _selectedDeadlines.clear();
      _totalAmount = 0.0;
      _isSelecting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool hasDeadlines = overdueFees.isNotEmpty || upcomingFees.isNotEmpty;

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    ' Deadlines',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),

                  if (overdueFees.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                fontSize: 18,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: overdueFees.map((fee) => buildDeadlineItem(fee, true, overdueFees.indexOf(fee))).toList(),
                    ),
                    const SizedBox(height: 40),
                  ],

                  if (upcomingFees.isNotEmpty) ...[
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
                      children: upcomingFees.map((fee) => buildDeadlineItem(fee, false, upcomingFees.indexOf(fee))).toList(),
                    ),
                    const SizedBox(height: 190),
                  ],

                  if (!hasDeadlines) ...[
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 250),
                          Text(
                            'There are no more tuition \nfees to pay',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 24,
                              color: CupertinoColors.systemGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (hasDeadlines)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: _selectedDeadlines.isNotEmpty
                      ? () {
                          showPayModal(context, _totalAmount, _removeSelectedDeadlines);
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
