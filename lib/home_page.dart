import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:intl/intl.dart';
import 'utils.dart';

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
  void initState() {
    super.initState();
    // Adding initial university transactions to all transactions
    allTransactions.addAll(universityTransactions);
  }

  void _addUniversityTransaction(String title, String amount, DateTime date) {
    setState(() {
      Map<String, String> newTransaction = {
        'title': title,
        'amount': amount,
        //'date': DateFormat('d MMMM yyyy').format(date),
      };
      universityTransactions.insert(0, newTransaction); // Insert at the beginning
      allTransactions.insert(0, newTransaction); // Insert at the beginning for all transactions as well
    });
  }

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
                    ? _buildBankAccountCard(context)
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
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
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
                        child: ListView.builder(
                          controller: scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: showUniversityTransactions
                              ? universityTransactions.length
                              : allTransactions.length,
                          itemBuilder: (context, index) {
                            final transaction = showUniversityTransactions
                                ? universityTransactions[index]
                                : allTransactions[index];
                            return _buildTransactionItem(transaction);
                          },
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

  Widget _buildBankAccountCard(BuildContext context) {
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
          SizedBox(height: 15),
          Text(
            '\€ 1,000.00',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CupertinoButton(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                onPressed: () {},
                child: Text(
                  'Transactions',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAllCardsView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: 4, // For now, just displaying 4 placeholder cards
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: PlaceholderWidget('Card ${index + 1}'),
          );
        },
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, String> transaction) {
    return ListTile(
      leading: Icon(Icons.account_balance_wallet),
      title: Text(
        transaction['title'] ?? '',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(transaction['date'] ?? ''),
      trailing: Text(
        transaction['amount'] ?? '',
        style: TextStyle(
            color: double.parse(transaction['amount']!.replaceAll(
                        new RegExp(r'[^\w\s]+'),'')) < 0
                ? Colors.red
                : Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 16),
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
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
