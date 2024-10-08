import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'deadlines.dart' as deadlinesinstallments;
import 'utils.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'profile_stud.dart';
import 'all_in_one_deadline.dart' as all_in_one_deadline;
import 'package:badges/badges.dart' as badges;


// Define a global ValueNotifier
ValueNotifier<Widget> selectedDeadlinePage = ValueNotifier<Widget>(deadlinesinstallments.DeadlinesPage());
ValueNotifier<bool> hasOverdueFees = ValueNotifier<bool>(true);


bool showUniversityTransactions = false;
bool isUniBankAccountSelected = true;
double balance = 2500.00;

void updateBalance(double newBalance) {
      balance = newBalance;
  }

List<Map<String, String>> universityTransactions = [
   
    {
      'title': 'Discolazio',
      'amount': '+ €170.00',
      'date': '15 March 2023',
    },
    
    {
      'title': 'Regional Tax',
      'amount': '- €140.00',
      'date': '11 March 2023',
    },
   
    {
      'title': 'Discolazio',
      'amount': '+ €50.00',
      'date': '15 February 2023',
    },
    {
      'title': 'Discolazio',
      'amount': '+ €50.00',
      'date': '20 January 2023',
    },
    
  ];

  List<Map<String, String>> allTransactions = [
    {
      'title': 'Library Fee',
      'amount': '- €50.00',
      'date': '20 May 2023',
    },
  ];



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

  // Update the widget options to use the ValueNotifier for deadlines page
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    ValueListenableBuilder<Widget>(
      valueListenable: selectedDeadlinePage,
      builder: (context, value, child) {
        return value;
      },
    ),
    ProfileScreen(), // Update this line to use the new ProfileScreen
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void checkOverdueFees() {
    hasOverdueFees.value = overdueFees.isNotEmpty;
  }


  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    checkOverdueFees();

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: ValueListenableBuilder<bool>(
        valueListenable: hasOverdueFees,
        builder: (context, value, child) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.house_fill),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: badges.Badge(
                  showBadge: value,
                  badgeContent: Text('1', style: TextStyle(color: Colors.white)),
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: Colors.red,
                  ),
                  child: Icon(CupertinoIcons.clock_fill),
                ),
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
          );
        },
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();
  DraggableScrollableController _draggableController = DraggableScrollableController();
  bool isSheetExpanded = false; // Track the state of the DraggableScrollableSheet
  

  @override
  void initState() {
    super.initState();
    // Adding initial university transactions to all transactions
    allTransactions.addAll(universityTransactions);

    // Listen for changes in the DraggableScrollableController
    _draggableController.addListener(() {
      setState(() {
         isSheetExpanded = _draggableController.size > 0.4;
      });
    });
  }

  void _addUniversityTransaction(String title, String amount, DateTime date) {
    setState(() {
      Map<String, String> newTransaction = {
        'title': title,
        'amount': amount,
        'date': DateFormat('d MMMM yyyy').format(date),
      };
      universityTransactions.insert(0, newTransaction); // Insert at the beginning
      allTransactions.insert(0, newTransaction); // Insert at the beginning for all transactions as well
    });
  }

  
  void _toggleSheetSize() {
    if (_draggableController.size > 0.4) {
      _draggableController.jumpTo(0.4); // Minimize the sheet
    } else {
      _draggableController.jumpTo(1.0); // Fully expand the sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
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
                      controller: _draggableController,
                      builder: (context, scrollController) {
                        _scrollController = scrollController; // Attach the scroll controller
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
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            SizedBox(height: 140), // Additional spacing before the ListView
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
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: GestureDetector(
                          onVerticalDragUpdate: (details) {
                            double newSize = _draggableController.size -
                              details.primaryDelta! / context.size!.height;
                            newSize = newSize.clamp(0.0, 1.0); // Ensure the size is within [0, 1]
                            _draggableController.jumpTo(newSize);
                            },
                          onVerticalDragEnd: (details) {
                            double newSize = _draggableController.size -
                                details.primaryVelocity! / context.size!.height;
                            newSize = newSize.clamp(0.0, 1.0); // Ensure the size is within [0, 1]
                            _draggableController.animateTo(
                              newSize,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
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
                                    onPressed: _toggleSheetSize,
                                    child: Text(
                                      isSheetExpanded ? 'Minimize' : 'View All',
                                      style: TextStyle(color: Colors.grey, fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
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
  
  @override
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
          SizedBox(height: 10),
          Text(
            'Card **** **** **** 1234',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 20),
          Text(
            '€ ${balance.toStringAsFixed(2)}',
            style: TextStyle(
                color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CupertinoButton(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: const Text(
                  'Add money',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () => _showAddMoneyModal(context),
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
void _showAddMoneyModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => AddMoneyModal(
        onAmountAdded: (amount) {
          setState(() {
            balance += amount;
            // Adding a new university transaction
            _addUniversityTransaction('Wire transfer', '€${amount.toStringAsFixed(2)}', DateTime.now());
          });
        },
      ),
    );
  }
}

class AddMoneyModal extends StatefulWidget {
  final Function(double) onAmountAdded;

  AddMoneyModal({required this.onAmountAdded});

  @override
  _AddMoneyModalState createState() => _AddMoneyModalState();
}

class _AddMoneyModalState extends State<AddMoneyModal> {
  int? _selectedOption;
  String _amount = '';
  bool _isAmountValid = false;
  bool _showError = false;

  void _updateAmount(String value) {
    setState(() {
      _amount = value;
      _isAmountValid = double.tryParse(value) != null && double.parse(value) > 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.white,
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Add Money',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel', style: TextStyle(color: Colors.black)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        trailing: _isAmountValid
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text('Next', style: TextStyle(color: Colors.black)),
                onPressed: () {
                  widget.onAmountAdded(double.parse(_amount));
                  _showDoneOverlay(context);
                },
              )
            : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Column(
          children: [
            _buildOptionRow(0, 'Card **** **** **** 1928'),
            _buildOptionRow(1, 'Card **** **** **** 5678'),
            _buildOptionRow(2, 'Card **** **** **** 0886'),
            SizedBox(height: 20),
            if (_showError)
              Text(
                'Choose an option before entering an amount',
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoTextField(
                autofocus: _selectedOption != null,
                placeholder: 'Enter amount',
                keyboardType: TextInputType.number,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 18),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CupertinoColors.systemGrey3,
                    width: 0.4,
                  ),
                ),
                enabled: _selectedOption != null,
                onChanged: _updateAmount,
                onTap: () {
                  if (_selectedOption == null) {
                    setState(() {
                      _showError = true;
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow(int index, String text) {
  // Define the path to the image asset corresponding to the index
  String imagePath = 'assets/card${index + 1}.png';

  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedOption = index;
        _showError = false;
      });
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: CupertinoColors.systemGrey4,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            _selectedOption == index
                ? CupertinoIcons.check_mark_circled_solid
                : CupertinoIcons.circle,
            color: _selectedOption == index
                ? Color.fromARGB(255, 130, 36, 61)
                : CupertinoColors.inactiveGray,
          ),
          SizedBox(width: 10),
          Image.asset(
            imagePath,
            width: 50,
            height: 30,
          ),
          SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    ),
  );
}

  void _showDoneOverlay(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (_) => CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              CupertinoIcons.check_mark_circled,
              color: CupertinoColors.systemGrey,
              size: 100,
            ),
            SizedBox(height: 10),
            Text(
              'Done',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }
}




 final Map<String, String> imagePaths = {
    "Grocery": 'assets/borgir.png',
    "Library Fee": 'assets/book.png',
    "Cinema": 'assets/cinema.png',
    "Regional Tax": 'assets/logo.png',
    "Discolazio": 'assets/discolaziooo.png',
    "1st Tuition Fee": 'assets/logo.png',
    "2nd Tuition Fee": 'assets/logo.png',
    "3rd Tuition Fee": 'assets/logo.png',
    "1st & 2nd Tuition Fee": 'assets/logo.png',
    "1st & 3rd Tuition Fee": 'assets/logo.png',
    "2nd & 1st Tuition Fee": 'assets/logo.png',
    "2nd & 3rd Tuition Fee": 'assets/logo.png',
    "3rd & 2nd Tuition Fee": 'assets/logo.png',
    "3rd & 1st Tuition Fee": 'assets/logo.png',
    "1st & 2nd & 3rd Tuition Fee": 'assets/logo.png',
    "1st & 3rd & 2nd Tuition Fee": 'assets/logo.png',
    "2nd & 1st & 3rd Tuition Fee": 'assets/logo.png',
    "2nd & 3rd & 1st Tuition Fee": 'assets/logo.png',
    "3rd & 2nd & 1st Tuition Fee": 'assets/logo.png',
    "3rd & 1st & 3rd Tuition Fee": 'assets/logo.png',




  };

 Widget _buildTransactionItem(Map<String, String> transaction) {
  // Get the image path based on the transaction title
  String imagePath = imagePaths[transaction['title']] ?? 'assets/wallet.png';

  // Determine text color based on amount sign
  bool isIncome = transaction['amount'].toString().startsWith('+');
  bool isTuitionFee = transaction['title'].toString().contains('Tuition Fee');
  bool isWireTransfer = transaction['title'].toString() == 'Wire transfer';

  // Determine the color based on the conditions
  Color amountColor = Colors.white;
  String amountText = transaction['amount']!;

  if (isIncome || isWireTransfer) {
    amountColor = Colors.green;
    if (isWireTransfer && !amountText.startsWith('+')) {
      amountText = '+ ' + amountText;
    }
  } else if (isIncome == false || isTuitionFee == false) {
    amountColor = Colors.red;
    if (isTuitionFee && !amountText.startsWith('-')) {
      amountText = '- ' + amountText;
    }
  }
  // Debug print to check the image path
  print('Loading image: $imagePath');

  return Container(
    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromARGB(232, 217, 217, 217)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Image.asset(
          imagePath, // Use the dynamic image path
          width: 38, // Adjust the width as needed
          height: 38, // Adjust the height as needed
          errorBuilder: (context, error, stackTrace) {
            // Display a default icon if the image fails to load
            return Icon(Icons.error, size: 24, color: Colors.red);
          },
        ),
        SizedBox(width: 10), // Adjust the spacing between image and text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transaction['title']!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(transaction['date']!, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
        Text(
          amountText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: amountColor),
        ),
      ],
    ),
  );
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


// Top-level function for subtracting university transaction
void subtractUniversityTransaction({
  required String title,
  required String amount,
  required DateTime date,
  required void Function(void Function()) setStateCallback,
  required List<Map<String, String>> universityTransactions,
  required List<Map<String, String>> allTransactions,
  required double balance,
}) {
  setStateCallback(() {

    String formattedAmount = "- €${amount}";

    Map<String, String> newTransaction = {
      'title': title,
      'amount': formattedAmount,
      'date': DateFormat('d MMMM yyyy').format(date),
    };
    universityTransactions.insert(0, newTransaction);
    allTransactions.insert(0, newTransaction);
    balance -= double.parse(amount.substring(1)); // Subtracting amount from balance
  });
}
