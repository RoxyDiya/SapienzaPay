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
  bool _isSelecting = false;
  Set<Map<String, String>> _selectedDeadlines = {};

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
    {'month': 'MAR', 'day': '10', 'year': '2024', 'description': '3rd TUITION FEE', 'amount': '€805'}
  ];
  final List<Map<String,String>> paymentmeth = [
    {'icon':'sapienzalogo.png', 'accname': 'University Bank Account'},
    {'icon': 'visalogo.png', 'accname': 'Card **** **** **** 9876'},
    {'icon': 'mclogo.png', 'accname':'Card **** **** **** 1928'}
  ];

  void _onDeadlineTap(Map<String, String> deadline) {
    if (_isSelecting) {
      _toggleSelection(deadline);
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DeadlineDetailsPage(deadline: deadline),
        ),
      );
    }
  }

  void _onDeadlineLongPress(Map<String, String> deadline) {
    setState(() {
      _isSelecting = true;
      _selectedDeadlines.add(deadline);
    });
  }

  void _toggleSelection(Map<String, String> deadline) {
    setState(() {
      if (_selectedDeadlines.contains(deadline)) {
        _selectedDeadlines.remove(deadline);
        if (_selectedDeadlines.isEmpty) {
          _isSelecting = false;
        }
      } else {
        _selectedDeadlines.add(deadline);
      }
    });
  }

  void _singleselection(Map<String,String> meth) {
   //SINGLE SELECTION LOGIC, ONCE YOU PAY IT OPENS THE SECOND MODAL!!! 
  }

  Widget buildPaymentMeth (Map<String, String> payment) {
    return GestureDetector(
      onTap: () => _singleselection(payment),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          border: Border.all(
            color: Color.fromARGB(255, 100, 100, 100)
            ),
        ),
        width: double.infinity,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start, //prolly gotta be different
              children: [
                //ADD THE CIRCLE FOR MULTIPLE SELECTION FROM CUPERTINO,
                Text(payment['icon']!),
                Text(payment['accname']!)
              ]
            )]
          )
      ),
    );
  }

  void _payModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Scaffold( //Scaffold might not work for modals
          body: SingleChildScrollView(
            child: 
              Column(
                children: [
                  Row(
                    children: [
                      //ADD ALIGNMENT
                      Text(
                        'Cancel'
                        //ADD ONTAP GO BACK TO DEADLINES (WITH SAME SELECTIONS RIGHT?)
                      ),
                      Text(
                        'Payment Method',
                        style: TextStyle(fontWeight: FontWeight.bold)
                      )
                    ]
                  ),
                  //PAYMENT METHOD MTHD
                ]
              )
          )
        );
      }
    );
  }
  
  Widget buildDeadlineItem(Map<String, String> deadline, bool isOverdue) {
    bool isSelected = _selectedDeadlines.contains(deadline);
    return GestureDetector(
      onTap: () => _onDeadlineTap(deadline),
      onLongPress: () => _onDeadlineLongPress(deadline),
      child: Container(
        //padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
        decoration: BoxDecoration(
          color: isSelected
            ? Colors.red[200]
            : isOverdue
              ? Colors.red[100]
              : Colors.white,
          borderRadius: BorderRadius.circular(0.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 1.0), 
        width: double.infinity, //maybe this will fill the whole screen
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // mainAxisSize: MainAxisSize.max, //as a possibile fix
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
                    color: isSelected
                      ? Colors.grey[800]
                      : Colors.grey[500]
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text(
                deadline['description']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                deadline['amount']!,
                style: TextStyle(fontWeight: FontWeight.bold),
              )],
            ),
            Icon(CupertinoIcons.right_chevron), //qui ce va la freccetta
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
          padding: const EdgeInsets.all(0.0), //removed inset to see if it covers the whole screen
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
                child: ElevatedButton( 
                  onPressed: _selectedDeadlines.isNotEmpty
                  ? () {
                    //_payModal(context);
                  }
                  : null,
                  child: const Text('Pay Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      )
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedDeadlines.isNotEmpty
                    ? Color.fromARGB(255, 111, 20, 28)
                    : Colors.grey[500],
                    padding: EdgeInsets.symmetric(vertical:16.0, horizontal: 20.0), //added horizontal padding hoping it makes text better
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


/*code where I have made the page scrollable and added the list items
TODO: add these actions
- when clicking Pay, it should open a modal/page to select means of payment, then a riepilogo, then a done widget and navigation back to the deadlines page with the previously selected items removed + subtract money from the card in the home page + only allow the payment to happen if there is enough money + add the transaction to the list in the home page. 
*/
