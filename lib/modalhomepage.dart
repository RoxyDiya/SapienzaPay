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
        primaryColor: Color.fromARGB(1000, 130, 36, 61),
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
    TextStyle labelStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w600);
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
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        selectedLabelStyle: labelStyle,
        unselectedLabelStyle: labelStyle.copyWith(color: Colors.grey),
        iconSize: 30,
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
  bool isUniBankAccountSelected = true;

  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.6,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 5,
                    width: 40,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      controller: scrollController,
                      children: showUniversityTransactions
                          ? universityTransactions
                          : allTransactions,
                    ),
                  ),
                ],
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
                      color: isUniBankAccountSelected
                          ? Color.fromARGB(1000, 130, 36, 61).withOpacity(0.4)
                          : Color.fromARGB(1000, 130, 36, 61).withOpacity(0.1),
                      onPressed: () {
                        setState(() {
                          isUniBankAccountSelected = true;
                        });
                      },
                      child: const Text(
                        'Uni Bank Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                  SizedBox(width: 22),
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: !isUniBankAccountSelected
                          ? Color.fromARGB(1000, 130, 36, 61).withOpacity(0.4)
                          : Color.fromARGB(1000, 130, 36, 61).withOpacity(0.1),
                      onPressed: () {
                        setState(() {
                          isUniBankAccountSelected = false;
                        });
                      },
                      child: const Text(
                        'All cards',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              isUniBankAccountSelected
                  ? _buildBankAccountCard()
                  : _buildAllCardsView(),
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
                Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: CupertinoSegmentedControl<int>(
                            children: {
                              0: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18, color: showUniversityTransactions ? Colors.black : CupertinoColors.inactiveGray),
                                ),
                              ),
                              1: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'University',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18, color: showUniversityTransactions ? CupertinoColors.inactiveGray : Colors.black),
                                ),
                              ),
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
                            pressedColor: CupertinoColors.lightBackgroundGray,
                          ),
                        ),
                        SizedBox(height: 17),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Last transactions',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20),
                            ),
                            CupertinoButton(
                              padding: EdgeInsets.all(7.0),
                              onPressed: () => _showModal(context),
                              child: Text(
                                'View All',
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: ListView(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 16),
                            children: showUniversityTransactions
                                ? universityTransactions
                                : allTransactions,
                          ),
                        ),
                      ],
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

  Widget _buildBankAccountCard() {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Color.fromARGB(232, 98, 23, 43),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UNI BANK ACCOUNT BALANCE',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'Card * * ** 1234',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            '€ 2500,00',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20), // Adjust the radius value as needed
              ),
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                onPressed: () {},
                child: const Text(
                  'Add money',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCardsView() {
    return Column(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text('Fake Card 1'),
            subtitle: Text('* * ** 1234'),
            trailing: Icon(Icons.credit_card),
          ),
        ),
        SizedBox(height: 20),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text('Fake Card 2'),
            subtitle: Text('**** **** **** 5678'),
            trailing: Icon(Icons.credit_card),
          ),
        ),
      ],
    );
  }

  final List<Widget> allTransactions = [
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('Second Instalment 23/24', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('Today'),
        trailing: Text('€1800', style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('Mensa Economia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('17th Feb, 13:02'),
        trailing: Text('-€2.20', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('Mensa Economia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('17th Feb, 19:02'),
        trailing: Text('-€2.20', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('2° Tuition Fee', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('26th Jan, 16:30'),
        trailing: Text('-€156', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('Mensa Economia', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('19th Jan, 12:02'),
        trailing: Text('-€2.20', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
  ];

  final List<Widget> universityTransactions = [
    Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('Second Instalment 23/24', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('Today'),
        trailing: Text('€1800', style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
    ),
    Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      padding: EdgeInsets.all(12),
      child: ListTile(
        title: Text('2° Tuition Fee', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        subtitle: Text('26th Jan, 16:30'),
        trailing: Text('-€156', style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
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