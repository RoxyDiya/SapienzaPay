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
        primaryColor: Color.fromARGB(255, 111, 20, 28),
      ),
      home: const HomePage(),
    );
  }
}


class DeadlinesPage extends StatefulWidget {
  const DeadlinesPage({super.key});

  @override
  _DeadlinesPageState createState() => _DeadlinesPageState();
}

class _DeadlinesPageState extends State<DeadlinesPage> {
  int _selectedIndex=1;

  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    DeadlinesPage(),
    PlaceholderWidget('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, String>> overdueFees = [
    {'date': 'NOV 15', 'description': '1st TUITION FEE', 'amount': '€766'},
  ];
  final List<Map<String, String>> upcomingFees = [
    {'date': 'DEC 19', 'description': '2nd TUITION FEE', 'amount': '€670'},
    {'date': 'MAR 1O', 'description': '3rd TUITION FEE', 'amount': '€805'}
  ];
  Widget buildDeadlineItem(Map<String, String> deadline) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                deadline['date']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade700,
                ),
              ),
              Text(
                deadline['description']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Text(
            deadline['amount']!,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Deadlines'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Deadlines',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'OVERDUE',
                style: TextStyle(color: Color.fromARGB(255, 111, 20, 28,), fontWeight: FontWeight.bold, fontSize: 24)
                ),
              SizedBox(height:20),
              Column(
                children: overdueFees
                  .map((fee)=> buildDeadlineItem(fee))
                  .toList(),
              ), //LIST OF UPCOMING TAXES AS LIGHT RED BUTTONS
              SizedBox(height:10),
              Text(
                'UPCOMING',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 111, 20,28))
              ),
              SizedBox(height:20),
              Column(
                children: upcomingFees
                  .map((fee) => buildDeadlineItem(fee))
                  .toList(),
              ),
              SizedBox(height:20),
              Center(
                child: ElevatedButton( //MAKE THIS GREY AND CHANGE ITS COLOUR ONCE YOU HAVE SELECTED
                  onPressed: () { //AT LEAST ONE OF THE TAXES TO PAY
                    //navigation action
                  },
                  child: const Text('Pay'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 111, 20, 28),
                    padding: const EdgeInsets.symmetric(vertical:16.0),
                    textStyle: const TextStyle(fontSize: 18),
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


/*code where I have made the page scrollable and added the list items
TODO: add these actions
- navigate to details on long tap
- */
