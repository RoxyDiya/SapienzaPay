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
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
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
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CupertinoSlidingSegmentedControl<int>(
                            children: {
                              0: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'All',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18, color: showUniversityTransactions ? Colors.black : CupertinoColors.black),
                                ),
                              ),
                              1: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  'University',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold, fontSize: 18, color: showUniversityTransactions ? CupertinoColors.black : Colors.black),
                                ),
                              ),
                            },
                            onValueChanged: (int? val) {
                              setState(() {
                                showUniversityTransactions = val == 1;
                              });
                            },
                            groupValue: showUniversityTransactions ? 1 : 0,
                            backgroundColor: CupertinoColors.lightBackgroundGray,
                            thumbColor: CupertinoColors.white,
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
                              onPressed: () {},
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
                DraggableScrollableSheet(
                  initialChildSize: 0.6,
                  minChildSize: 0.6,
                  maxChildSize: 1.0,
                  builder: (BuildContext context, ScrollController scrollController) {
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
                ),
              ],
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
            'Sapienza Bank',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
          SizedBox(height: 15),
          Text(
            '\$ 26,531.55',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
          ),
          SizedBox(height: 20),
          Text(
            'IBAN: IT23 A033 5901 6320 0348 9013 293',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCardsView() {
    return Column(
      children: [
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color.fromARGB(232, 98, 23, 43),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UniCredit Mastercard',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  '\$ 6,532.50',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Color.fromARGB(232, 98, 23, 43),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intesa Sanpaolo Visa',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
                ),
                SizedBox(height: 15),
                Text(
                  '\$ 5,352.30',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> get universityTransactions {
    return [
      _buildTransactionItem('University Fees', 'Paid', '- \$ 530.00'),
      _buildTransactionItem('Book Store', 'Paid', '- \$ 85.50'),
      _buildTransactionItem('Cafeteria', 'Paid', '- \$ 5.30'),
    ];
  }

  List<Widget> get allTransactions {
    return [
      _buildTransactionItem('Amazon', 'Completed', '- \$ 120.00'),
      _buildTransactionItem('Electricity Bill', 'Pending', '- \$ 45.00'),
      _buildTransactionItem('Grocery Store', 'Completed', '- \$ 70.20'),
    ];
  }

  Widget _buildTransactionItem(String title, String status, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                status,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
