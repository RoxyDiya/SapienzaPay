import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';

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
    TextStyle labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(CupertinoIcons.chevron_left),
                    Text(
                      'Deadlines'
                    ),
                  ],
                ),
            ),
            Placeholder(fallbackHeight: 70),
            Row(), //tuition fee info
            Row(),  //spaceevenly, needs border lines above and below
            Row(),
            Row(),
            Row(),
            Row(),
            SizedBox(height: 200),
            Text('DUE ON ...',
              style: TextStyle(
                color: Color.fromARGB(255, 111, 20, 28),
                  fontWeight: FontWeight.bold,
                  fontSize: 22
              ),
            ),
            Text('(expired)'), //only put this one if it's overdue
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text('E766')
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [PlaceholderWidget('Pay Now')],)
          ]
        )
      ),
      /*
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
      ), */
    );
  }
}
