import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';
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
        primaryColor: Color.fromARGB(255, 111, 20, 28),
      ),
      home: const HomePage(),
    );
  }
}

class DeadlineDetailsPage extends StatefulWidget {
  final Map<String, String> deadline;
  const DeadlineDetailsPage({super.key, required this.deadline});

  @override
  _DeadlineDetailsState createState() => _DeadlineDetailsState();
}

class _DeadlineDetailsState extends State<DeadlineDetailsPage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DeadlinesPage(),
    PlaceholderWidget('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(1000, 130, 36, 61).withOpacity(0.7),
            height: MediaQuery.of(context).size.height * 0.25, // Reduced height
            child: Center(
              child: ClipOval(
                child: Image.network(
                  'https://via.placeholder.com/100',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            color: Color.fromARGB(255, 111, 20, 28),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.chevron_left, color: Colors.black),
                      Text(
                        'Deadlines',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Placeholder(fallbackHeight: 70), //sapienza Icon
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('1° Tuition Fee',
                        style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 111, 20, 28))),
                  ],
                ),
                SizedBox(height: 15),
                Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('A.A. Year:', style: TextStyle(fontSize: 20)),
                    Text('23/24', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Status:', style: TextStyle(fontSize: 20)),
                    Text('Unpaid', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Regional Tax', style: TextStyle(fontSize: 20)),
                    Text('€140', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Postage Stamp', style: TextStyle(fontSize: 20)),
                    Text('€16', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('First Installment', style: TextStyle(fontSize: 20)),
                    Text('€550', style: TextStyle(fontSize: 20)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Penalty Fee', style: TextStyle(fontSize: 20)),
                    Text('€60', style: TextStyle(fontSize: 20)),
                  ],
                ),
                SizedBox(height: 200),
                Text(
                  'DUE ON 15/11/2023',
                  style: TextStyle(
                    color: Color.fromARGB(255, 111, 20, 28),
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  '(Expired)',
                  style: TextStyle(
                      color: CupertinoColors.inactiveGray, fontSize: 22),
                ), //only put this one if it's overdue
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('€766')],
                ),
                Center(
                  child: ElevatedButton(
                    child: const Text(
                      'Pay Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: selectedDeadlines.isNotEmpty
                        ? () {
                            payModal(context);
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedDeadlines.isNotEmpty
                          ? const Color.fromARGB(255, 111, 20, 28)
                          : Colors.grey[500],
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 20.0),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.clock_fill), label: 'Deadlines'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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
