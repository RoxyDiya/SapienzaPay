import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'deadlines.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 111, 20, 28),
      ),
      home: const HomePage(),
    );
  }
}

class DeadlineDetailsPage extends StatefulWidget {
  final Map<String, String> deadline;
  const DeadlineDetailsPage({super.key, required this.deadline});

  @override
  _DeadlineDetailsState createState() => _DeadlineDetailsState();
}

class _DeadlineDetailsState extends State<DeadlineDetailsPage> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    DeadlinesPage(),
    PlaceholderWidget('Profile')
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deadline = widget.deadline;
    TextStyle labelStyle = TextStyle(fontSize: 12, fontWeight: FontWeight.w600);
    TextStyle detailStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
    
    bool isOverdue = DateTime.parse('${deadline['year']}-${deadline['month']}-${deadline['day']}').isBefore(DateTime.now());

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(CupertinoIcons.chevron_left),
                  Text('Deadlines'),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/sapienzalogo.png', height: 100), // Replace with your logo asset
                  Text(
                    '${deadline['description']}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('A.A. Year:', style: labelStyle),
                Text('23/24', style: detailStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Status:', style: labelStyle),
                Text('Unpaid', style: detailStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Regional Tax:', style: labelStyle),
                Text('€140', style: detailStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Postage Stamp:', style: labelStyle),
                Text('€16', style: detailStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('First Installment:', style: labelStyle),
                Text('€550', style: detailStyle),
              ],
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Penalty fee:', style: labelStyle),
                Text('€60', style: detailStyle),
              ],
            ),
            Divider(),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Text(
                    'DUE ON ${deadline['day']}/${deadline['month']}/${deadline['year']}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 111, 20, 28),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  if (isOverdue)
                    Text(
                      '(Expired)',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: Text(
                '€${deadline['amount']}',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement pay now action
                },
                child: Text(
                  'Pay Now',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 111, 20, 28),
                  padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
