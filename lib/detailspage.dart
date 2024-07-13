import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';
import 'profile_stud.dart';
import 'utils.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';
import 'profile_stud.dart'; // Assuming profile_stud.dart contains ProfileScreen

class DeadlineDetailsPage extends StatefulWidget {
  final Map<String, String> deadline;

  const DeadlineDetailsPage({super.key, required this.deadline});

  @override
  _DeadlineDetailsPageState createState() => _DeadlineDetailsPageState();
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

class _DeadlineDetailsPageState extends State<DeadlineDetailsPage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DeadlinesPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 130, 36, 61),
            height: MediaQuery.of(context).padding.top + 44, // height of status bar + navigation bar
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 130, 36, 61),
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                    ),
                  ),
                ),
                Container(
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Text(
                              '1° Tuition Fee',
                              style: TextStyle(
                                fontSize: 26,
                                color: Color.fromARGB(255, 111, 20, 28),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'A.A. Year: 23/24',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              'Status: Unpaid',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                      SizedBox(height: 10),
                      _buildFeeRow('Regional Tax', '€140'),
                      _buildFeeRow('Postage Stamp', '€16'),
                      _buildFeeRow('First Installment', '€550'),
                      _buildFeeRow('Penalty Fee', '€60'),
                      SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
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
                                color: CupertinoColors.inactiveGray,
                                fontSize: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          '€766',
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 111, 20, 28),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: CupertinoButton.filled(
                          onPressed: () {},
                          child: const Text(
                            'Pay Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                CupertinoTabBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.clock_fill), label: 'Deadlines'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
                  ],
                  currentIndex: _selectedIndex,
                  activeColor: Color.fromARGB(255, 130, 36, 51),
                  inactiveColor: Colors.grey,
                  onTap: _onItemTapped,
                ),
              ],
            ),
          ),
          CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              previousPageTitle: 'Deadlines',
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 130, 36, 61).withOpacity(0.7),
            border: Border(
              bottom: BorderSide.none, // Remove bottom shadow
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 111, 20, 28)),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 111, 20, 28)),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Home Screen"));
  }
}

class DeadlinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Deadlines Page"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}

void main() {
  runApp(CupertinoApp(
    theme: CupertinoThemeData(
      primaryColor: Color.fromARGB(255, 111, 20, 28),
    ),
    home: HomeScreen(),
  ));
}
