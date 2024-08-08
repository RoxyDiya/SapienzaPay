import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'detailspage.dart' as detailspage1;
import 'detailspage2.dart' as detailspage2;
import 'detailspage3.dart' as detailspage3;
import 'utils.dart';
import 'profile_par.dart';
import 'package:badges/badges.dart' as badges;

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
      home: const DeadlinesPage(),
    );
  }
}

class DeadlinesPage extends StatefulWidget {
  const DeadlinesPage({super.key});

  @override
  DeadlinesPageState createState() => DeadlinesPageState();
}

class DeadlinesPageState extends State<DeadlinesPage> {
  int _selectedIndex = 0;
  bool _isSelecting = false;
  Set<Map<String, String>> _selectedDeadlines = {};
  double _totalAmount = 0.0;
  bool hasOverdueFees = true;


  final List<Widget> _widgetOptions = <Widget>[
    ValueListenableBuilder<Widget>(
      valueListenable: selectedDeadlinePage,
      builder: (context, value, child) {
        return value;
      },
    ),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void checkOverdueFees() {
    setState(() {
      hasOverdueFees = overdueFees.isNotEmpty;
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
            removeSpecificDeadline: _removeSpecificDeadline,
          );
          break;
        case '2nd TUITION FEE':
          detailsPage = detailspage2.DeadlineDetailsPage(
            deadline: deadline,
            showPayModal: showPayModal,
            removeSpecificDeadline: _removeSpecificDeadline,
          );
          break;
        case '3rd TUITION FEE':
          detailsPage = detailspage3.DeadlineDetailsPage(
            deadline: deadline,
            showPayModal: showPayModal,
            removeSpecificDeadline: _removeSpecificDeadline,
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
      key: ValueKey(index),
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

  void _removeSpecificDeadline(Map<String, String> deadline) {
    print("removing deadline: $deadline");
    setState(() {
      overdueFees.removeWhere((fee) => fee == deadline);
      upcomingFees.removeWhere((fee) => fee == deadline);
    });
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
    TextStyle labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    checkOverdueFees();


    return Scaffold(
      body: _widgetOptions[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
          icon: badges.Badge(
              showBadge: hasOverdueFees
                ? true
                : false,
              badgeContent: Text('1', style: TextStyle(color: Colors.white)),
              badgeStyle: badges.BadgeStyle(
                shape: badges.BadgeShape.circle,
                badgeColor: Colors.red),
              child: Icon(CupertinoIcons.clock_fill),
            ),            
            label: 'Deadlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 130, 36, 51),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle.copyWith(color: Colors.grey),
        iconSize: 25,
      ),
    );
  }
}


