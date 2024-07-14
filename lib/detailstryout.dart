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
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 111, 20, 28),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(CupertinoIcons.chevron_left, color: Colors.white),
                      Text(
                        'Deadlines',
                        style: TextStyle(
                          color: Colors.white, 
                          fontSize: 22
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/RedLogo.png'),
                  ), // sapienza Icon
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('1° Tuition Fee',
                          style: TextStyle(
                              fontSize: 26,
                              color: Color.fromARGB(255, 111, 20, 28))),
                    ],
                  ), // tuition fee info
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
                  Text('(Expired)',
                      style: TextStyle(
                          color: CupertinoColors.inactiveGray, fontSize: 22)), // only put this one if it's overdue
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
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 111, 20, 28),
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 20.0),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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


