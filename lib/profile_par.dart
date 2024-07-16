import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';

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

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage2> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    PlaceholderWidget('Deadlines'),
    ProfileScreen(), // Update this line to use the new ProfileScreen
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.normal);
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
        iconSize: 25,
      ),
    );
  }
}

class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
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
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color.fromARGB(1000, 130, 36, 61),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Uni Bank Account',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
          ),
          SizedBox(height: 5),
          Text(
            '\$2,459.00',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildAllCardsView() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color.fromARGB(1000, 130, 36, 61),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Uni Bank Account',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'Total Balance',
                style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.7)),
              ),
              SizedBox(height: 5),
              Text(
                '\$2,459.00',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Credit Card',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              Text(
                'Total Balance',
                style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(0.7)),
              ),
              SizedBox(height: 5),
              Text(
                '\$1,245.00',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black),
              ),
            ],
          ),
        ),
      ],
    );
  }

  final List<Widget> universityTransactions = List.generate(
    10,
    (index) => ListTile(
      title: Text('University Transaction ${index + 1}'),
      subtitle: Text('Description of transaction ${index + 1}'),
      trailing: Text(
        '-\$${(index + 1) * 10}.00',
        style: TextStyle(color: Colors.red),
      ),
    ),
  );

  final List<Widget> allTransactions = List.generate(
    20,
    (index) => ListTile(
      title: Text('Transaction ${index + 1}'),
      subtitle: Text('Description of transaction ${index + 1}'),
      trailing: Text(
        index.isEven ? '-\$${(index + 1) * 10}.00' : '+\$${(index + 1) * 5}.00',
        style: TextStyle(color: index.isEven ? Colors.red : Colors.green),
      ),
    ),
  );
}

class PlaceholderWidget extends StatelessWidget {
  final String title;

  PlaceholderWidget(this.title);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) {
              return CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                  middle: Text('Home'),
                ),
                child: Center(child: Text('Home Tab')),
              );
            });
          case 1:
            return CupertinoTabView(builder: (context) {
              return ProfileScreen();
            });
          default:
            return Container();
        }
      },
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: Colors.white,
        middle: Text('Profile'),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 3),
              Text(
                'Account Details',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 20),
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your image asset
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Said Hajjaji',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Parent',
                        style: TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.inactiveGray,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) => EditProfileModal(),
                        isScrollControlled: true,
                      );
                    },
                    child: Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(1000, 130, 36, 61),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 40),
              Text(
                'Payment settings',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 5),
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('Payment options'),
                trailing: Icon(CupertinoIcons.right_chevron),
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => PaymentPlanScreen(),
                    ),
                  );
                },
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Enable deadline notifications',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    CupertinoSwitch(
                      value: false,
                      onChanged: (bool value) {
                        // Handle switch toggle
                      },
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[300]),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextButton(
                  onPressed: () {
                    // Handle sign out
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class EditProfileModal extends StatefulWidget {
  @override
  _EditProfileModalState createState() => _EditProfileModalState();
}

class _EditProfileModalState extends State<EditProfileModal> {
  TextEditingController phoneController = TextEditingController(text: '+39 370 307 53 54');
  bool isEditingPhoneNumber = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      navigationBar: CupertinoNavigationBar(
        leading:CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Cancel', style: TextStyle(color:Colors.black)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        middle: Text('Edit'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Text('Done', style: TextStyle(color:Colors.black)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 60),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/profile_picture.png'), // Replace with your image asset
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // Handle change picture
                      },
                      child: Text(
                        'Change Pic',
                        style: TextStyle(
                          color: Color.fromARGB(1000, 130, 36, 61),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('NAME: Firdaous'),
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('SURNAME: Hajjaji'),
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('STUDENT ID N°: 2006406'),
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('ENROLLMENT YEAR: 2021/22'),
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('COURSE NAME: ACSAI'),
              ),
              Divider(color: Colors.grey[300]),
              ListTile(
                title: Text('EMAIL: hajjaji.2006406@studenti.uni...'),
              ),
              Divider(color: Colors.grey[300]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PHONE NUMBER:',
                    style: TextStyle(fontSize: 16),
                  ),
                  Spacer(),
                  if (isEditingPhoneNumber)
                    Expanded(
                      child: CupertinoTextField(
                        controller: phoneController,
                        autofocus: true,
                      ),
                    )
                  else
                    Text(
                      phoneController.text,
                      style: TextStyle(fontSize: 16),
                    ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      setState(() {
                        isEditingPhoneNumber = !isEditingPhoneNumber;
                      });
                    },
                    child: Icon(
                      isEditingPhoneNumber ? CupertinoIcons.check_mark : CupertinoIcons.pencil,
                      color: CupertinoColors.systemGrey,
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.grey[300]),
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentPlanScreen extends StatefulWidget {
  @override
  _PaymentPlanScreenState createState() => _PaymentPlanScreenState();
}

class _PaymentPlanScreenState extends State<PaymentPlanScreen> {
  String _selectedPlan = 'Installments';

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xFFF7E8E8),
      navigationBar: CupertinoNavigationBar(
        middle: Text('Payment plan'),
        leading: CupertinoNavigationBarBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          previousPageTitle: 'Profile', color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 120),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    onPressed: () {
                      setState(() {
                        _selectedPlan = 'All-in-one';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'All-in-one',
                          style: TextStyle(
                            color: _selectedPlan == 'All-in-one' ? Colors.black : Colors.black,
                          ),
                        ),
                        if (_selectedPlan == 'All-in-one')
                          Icon(CupertinoIcons.check_mark, color: Color.fromARGB(1000, 130, 36, 61)),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey[300]),
                  CupertinoButton(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                    onPressed: () {
                      setState(() {
                        _selectedPlan = 'Installments';
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Installments',
                          style: TextStyle(
                            color: _selectedPlan == 'Installments' ? Colors.black : Colors.black,
                          ),
                        ),
                        if (_selectedPlan == 'Installments')
                          Icon(CupertinoIcons.check_mark, color: Color.fromARGB(1000, 130, 36, 61)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}