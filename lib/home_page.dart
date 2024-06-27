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
        primaryColor: Color.fromARGB(255, 130, 36, 61),
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
    TextStyle labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
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
      child: Stack(
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
                            ? Color.fromARGB(255, 130, 36, 61).withOpacity(0.4)
                            : Color.fromARGB(255, 130, 36, 61).withOpacity(0.1),
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
                            ? Color.fromARGB(255, 130, 36, 61).withOpacity(0.4)
                            : Color.fromARGB(255, 130, 36, 61).withOpacity(0.1),
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
          if (isUniBankAccountSelected)
            DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.4,
              maxChildSize: 0.93,
              builder: (context, scrollController) {
                return Container(
                  decoration: BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onVerticalDragUpdate: (details) {
                          // Forward the drag updates to the scrollController
                          scrollController.position.moveTo(
                            scrollController.position.pixels -
                                details.primaryDelta!,
                          );
                        },
                        child: Container(
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
                                  margin: EdgeInsets.only(top: 10, bottom: 10),
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
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: showUniversityTransactions
                                                ? Colors.black
                                                : CupertinoColors.black),
                                      ),
                                    ),
                                    1: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Text(
                                        'University',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: showUniversityTransactions
                                                ? CupertinoColors.black
                                                : Colors.black),
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
                              SizedBox(height: 10),
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
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          padding: EdgeInsets.zero, // Remove any padding
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
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildAllCardsView() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: 500,
          height: 370,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'CARD N°1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 210), // Adjust the spacing as needed
                  Image.asset(
                    'assets/mastercardlogo.png', // Replace with the path to your image
                    width: 40,  // Set the desired width
                    height: 40, // Set the desired height
                    //color: Colors.white, // Apply color filter if needed
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 500,
          height: 310,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'CARD N°2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 210), // Adjust the spacing as needed
                  Image.asset(
                    'assets/visalogo.png', // Replace with the path to your image
                    width: 40,  // Set the desired width
                    height: 40, // Set the desired height
                    //color: Colors.white, // Apply color filter if needed
                  ),
                ],
              ),              
            ],
          ),
        ),
        Container(
          width: 500,
          height: 250,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'CARD N°2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 210), // Adjust the spacing as needed
                  Image.asset(
                    'assets/mastercardlogo.png', // Replace with the path to your image
                    width: 40,  // Set the desired width
                    height: 40, // Set the desired height
                    //color: Colors.white, // Apply color filter if needed
                  ),
                ],
              ),   
              SizedBox(height: 110),
              Text(
                'Firdaous Hajjaji                                03/30',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 5),
              Text(
                '**** **** **** 0886',
                style: TextStyle(
                    color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
              ),              
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> get universityTransactions {
    return [
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Library Fee', '€50.00', '15 March 2023'),
    ];
  }

  List<Widget> get allTransactions {
    return [
      _buildTransactionItem('University Fee', '€300.00', '12 March 2023'),
      _buildTransactionItem('Grocery', '€50.00', '10 March 2023'),
      _buildTransactionItem('Cinema', '€15.00', '11 March 2023'),
      ...universityTransactions,
    ];
  }

  Widget _buildTransactionItem(String title, String amount, String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromARGB(232, 217, 217, 217)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(date, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
          Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}
