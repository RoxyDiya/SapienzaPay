import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'deadlines.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SapienzaPay',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 111, 20, 28),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('SapienzaPay'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock_fill),
            label: 'Deadlines',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(1000, 130, 36, 51),
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showUniversityTransactions = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Hi, Firdaous!',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Uni Bank Account'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('All cards'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNI BANK ACCOUNT BALANCE',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Card **** **** **** 1234',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '€ 2500,00',
                      style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('Add money'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20, width: double.infinity),
              Container(
                width: double.infinity, // Make the segmented control take full width
                padding: EdgeInsets.symmetric(horizontal: 16), // Add padding if needed
                child: CupertinoSegmentedControl<int>(
                  children: {
                    0: Text('All',style: TextStyle(color: Colors.black)),
                    1: Text('University',style: TextStyle(color: Colors.black) ),
                  },
                  onValueChanged: (int val) {
                    setState(() {
                      showUniversityTransactions = val == 1;
                    });
                  },
                  groupValue: showUniversityTransactions ? 1 : 0,
                  unselectedColor: CupertinoColors.lightBackgroundGray, // iOS grey for unselected segments
                  selectedColor: CupertinoColors.white, // iOS grey for selected segments
                  borderColor: CupertinoColors.lightBackgroundGray, // iOS grey for the border
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            children: showUniversityTransactions
                ? universityTransactions
                : allTransactions,
          ),
        ),
      ],
    );
  }

  final List<Widget> allTransactions = [
    ListTile(
      title: Text('Second Instalment 23/24'),
      subtitle: Text('Today'),
      trailing: Text('€1800', style: TextStyle(color: Colors.green)),
    ),
    ListTile(
      title: Text('Mensa Economia'),
      subtitle: Text('17th Feb, 13:02'),
      trailing: Text('-€2.20', style: TextStyle(color: Colors.red)),
    ),
    ListTile(
      title: Text('Mensa Economia'),
      subtitle: Text('17th Feb, 19:02'),
      trailing: Text('-€2.20', style: TextStyle(color: Colors.red)),
    ),
    ListTile(
      title: Text('2° Tuition Fee'),
      subtitle: Text('26th Jan, 16:30'),
      trailing: Text('-€156', style: TextStyle(color: Colors.red)),
    ),
    ListTile(
      title: Text('Mensa Economia'),
      subtitle: Text('19th Jan, 12:02'),
      trailing: Text('-€2.20', style: TextStyle(color: Colors.red)),
    ),
  ];

  final List<Widget> universityTransactions = [
    ListTile(
      title: Text('Second Instalment 23/24'),
      subtitle: Text('Today'),
      trailing: Text('€1800', style: TextStyle(color: Colors.green)),
    ),
    ListTile(
      title: Text('2° Tuition Fee'),
      subtitle: Text('26th Jan, 16:30'),
      trailing: Text('-€156', style: TextStyle(color: Colors.red)),
    ),
  ];
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  const PlaceholderWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('$text Page'),
    );
  }
}
