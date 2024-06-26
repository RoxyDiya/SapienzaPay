import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'detailspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'sapienzapay';
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
    {'month': 'NOV', 'day': '15', 'year': '2023', 'description': '1st TUITION FEE', 'amount': '€766'},
  ];
  final List<Map<String, String>> upcomingFees = [
    {'month': 'DEC', 'day': '19', 'year': '2024', 'description': '2nd TUITION FEE', 'amount': '€670'},
    {'month': 'MAR 1O', 'day': '10', 'year': '2024', 'description': '3rd TUITION FEE', 'amount': '€805'}
  ];
  Widget buildDeadlineItem(Map<String, String> deadline, bool isOverdue) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DeadlineDetailsPage(deadline: deadline),
          ),
        );
      },
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        decoration: BoxDecoration(
          color: isOverdue ? Colors.red.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max, //added this
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center, //changed from start to center
              children: [
                Text(
                  deadline['month']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                Text(
                  deadline['day']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700]
                    ),
                ),
                Text(
                  deadline['year']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[300]
                  ),
                ),
              ],
            ),
            Text(
              deadline['description']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              deadline['amount']!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //appBar: AppBar(
      //  title: Text('Deadlines'),
      //),
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
                  .map((fee)=> buildDeadlineItem(fee, true))
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
                  .map((fee) => buildDeadlineItem(fee, false))
                  .toList(),
              ),
              SizedBox(height:300),
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
- modify colour of pay button when at least one item is selected
- when clicking Pay, it should open a modal/page to select means of payment, then a riepilogo, then a done widget and navigation back to the deadlines page with the previously selected items removed + subtract money from the card in the home page + only allow the payment to happen if there is enough money + add the transaction to the list in the home page. 
*/
