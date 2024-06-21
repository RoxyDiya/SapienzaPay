import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
    PlaceholderWidget('Deadlines'),
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

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 1.0,
          minChildSize: 0.5,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: showUniversityTransactions
                    ? universityTransactions
                    : allTransactions,
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 70.0, 16.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hi, Firdaous!',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: CupertinoColors.systemGrey.withOpacity(0.5),
                        onPressed: () {},
                        child: const Text(
                          'Uni Bank Account',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: CupertinoButton(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        color: CupertinoColors.systemGrey.withOpacity(0.5),
                        onPressed: () {},
                        child: const Text(
                          'All cards',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CupertinoButton(
                          color: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          onPressed: () {},
                          child: const Text('Add money', style: TextStyle(color: Colors.black),),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Last transactions',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                CupertinoButton(
                  onPressed: () => _showModal(context),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'View All',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: CupertinoSegmentedControl<int>(
                    children: {
                      0: Text('All', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                      1: Text('University', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                    },
                    onValueChanged: (int val) {
                      setState(() {
                        showUniversityTransactions = val == 1;
                      });
                    },
                    groupValue: showUniversityTransactions ? 1 : 0,
                    unselectedColor: CupertinoColors.lightBackgroundGray,
                    selectedColor: CupertinoColors.white,
                    borderColor: CupertinoColors.lightBackgroundGray,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < -10) {
                  _showModal(context);
                }
              },
              child: Stack(
                children: [
                  ListView(
                    children: showUniversityTransactions
                        ? universityTransactions
                        : allTransactions,
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 40,
                        color: Colors.black.withOpacity(0.1),
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
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
  final String title;

  PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
