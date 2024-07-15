import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';
import 'profile_stud.dart'; // Assuming profile_stud.dart contains ProfileScreen

class DeadlineDetailsPage extends StatefulWidget {
  final Map<String, String> deadline;

  const DeadlineDetailsPage({super.key, required this.deadline});

  @override
  _DeadlineDetailsPageState createState() => _DeadlineDetailsPageState();
}

class _DeadlineDetailsPageState extends State<DeadlineDetailsPage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DeadlinesPage(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 130, 36, 61),
            height: MediaQuery.of(context).padding.top + 44, // height of status bar + navigation bar
          ),
          SafeArea(
            child: Column(
              children: [
                Container(
                  color: Color.fromARGB(255, 130, 36, 61),
                  padding: EdgeInsets.symmetric(vertical: 60),
                  width: double.infinity, // Ensure it stretches to the full width
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 15), // Add space for the CircleAvatar
                          Text(
                            '2° Tuition Fee',
                            style: TextStyle(fontSize: 24,color: Color.fromARGB(255, 111, 20, 28),fontWeight: FontWeight.bold,),
                          ),
                          SizedBox(height: 10),
                          Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'A.A. Year:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
                              ),
                              Text(
                                '23/24',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),

                          Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Status:',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
                              ),
                              Text(
                                'Unpaid',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 2),
                          Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                          SizedBox(height: 10),
                          _buildFeeRow('Postage Stamp', '€16'),
                          _buildFeeRow('Second Installment', '€654'),
                          SizedBox(height: 125),
                          
                                Text(
                                  'DUE ON 19/12/2023',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 111, 20, 28),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22,
                                  ),
                                ),
                                
                              
                          SizedBox(height: 107),
                          Center(
                            child: Text(
                              '€670',
                              style: TextStyle(
                                fontSize: 36,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.black,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                    'Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 24,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    fixedSize: Size.fromWidth(350),
                    backgroundColor: const Color.fromARGB(255, 111, 20, 28),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 20.0),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                            ),
                          ),
                          SizedBox(height: 50),

                        ],
                      ),
                    ),
                  ),
                ),
                CupertinoTabBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.clock_fill), label: 'Deadlines'),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person), label: 'Profile'),
                  ],
                  currentIndex: _selectedIndex,
                  activeColor: Color.fromARGB(255, 130, 36, 51),
                  inactiveColor: Colors.grey,
                  onTap: _onItemTapped,
                ),
              ],
            ),
          ),
          CupertinoNavigationBar(
            leading: CupertinoNavigationBarBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              previousPageTitle: 'Deadlines',
              color: Colors.white,
            ),
            backgroundColor: Color.fromARGB(255, 130, 36, 61).withOpacity(0.7),
            border: Border(
              bottom: BorderSide.none, // Remove bottom shadow
            ),
          ),
          Positioned(
            top: 110,
            left: MediaQuery.of(context).size.width / 2 - 45, // Adjust to center horizontally
            child: CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://via.placeholder.com/100'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal, color: CupertinoColors.black),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Home Screen"));
  }
}

class DeadlinesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Deadlines Page"));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Profile Screen"));
  }
}

void main() {
  runApp(CupertinoApp(
    theme: CupertinoThemeData(
      primaryColor: Color.fromARGB(255, 111, 20, 28),
    ),
    home: HomeScreen(),
  ));
}
