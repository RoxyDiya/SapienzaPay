import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';
import 'profile_stud.dart';
import 'utils.dart';

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
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  
@override
  Widget build(BuildContext context) {
    TextStyle labelStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 130, 36, 61).withOpacity(0.7),
        leading: IconButton(
          icon: Icon(CupertinoIcons.chevron_left),
          onPressed: () => Navigator.of(context).pop(),
          color: Colors.black,
          
        ),
         title: Row(
          children: [
            Text(
              "Deadlines",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromARGB(255, 130, 36, 61).withOpacity(0.7),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://via.placeholder.com/100'),
                ),
              ),
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text(
                          '1° Tuition Fee',
                          style: TextStyle(
                            fontSize: 26,
                            color: Color.fromARGB(255, 111, 20, 28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'A.A. Year: 23/24',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Status: Unpaid',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(color: CupertinoColors.inactiveGray, thickness: 0.5),
                  SizedBox(height: 10),
                  _buildFeeRow('Regional Tax', '€140'),
                  _buildFeeRow('Postage Stamp', '€16'),
                  _buildFeeRow('First Installment', '€550'),
                  _buildFeeRow('Penalty Fee', '€60'),
                  SizedBox(height: 20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'DUE ON 15/11/2023',
                          style: TextStyle(
                            color: Color.fromARGB(255, 111, 20, 28),
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        Text(
                          '(Expired)',
                          style: TextStyle(
                            color: CupertinoColors.inactiveGray,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      '€766',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 111, 20, 28),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 111, 20, 28),
                        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.clock_fill), label: 'Deadlines'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
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

  Widget _buildFeeRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 18),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
