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
      //title: 'sapienzapay';
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
    PlaceholderWidget('Profile')
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.chevron_left, color: Colors.black),
                    Text(
                      'Deadlines',
                      style: TextStyle(color: Colors.black) //ADD ACTION TO THIS
                    ),
                  ],
                ),
            ),
            Placeholder(fallbackHeight: 70), //sapienza Icon
            SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('1° Tuition Fee',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color.fromARGB(255, 111, 20, 28)
                  ))
              ],), //tuition fee info
            SizedBox(height: 25),
            Divider(color: CupertinoColors.inactiveGray, thickness: 0.5,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('A.A. Year:'),
                Text('23/24')
              ],),
            Divider(color: CupertinoColors.inactiveGray, thickness: 0.5,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Status:'),
                Text('Unpaid')
              ],),
            Divider(color: CupertinoColors.inactiveGray, thickness: 0.5,),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:[
                Text('Regional Tax'),
                Text('€140')
              ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Postage Stamp'),
                Text('€16')
              ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('First Installment'),
                Text('€550')
              ]),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Penalty Fee'),
                Text('€60')
              ]),
            SizedBox(height: 200),
            Text('DUE ON 15/11/2023',
              style: TextStyle(
                color: Color.fromARGB(255, 111, 20, 28),
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            Text('(Expired)',
              style: TextStyle(color: CupertinoColors.inactiveGray)), //only put this one if it's overdue
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('€766')
            ],),
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
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ]
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock_fill),
            label: 'Deadlines'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
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
