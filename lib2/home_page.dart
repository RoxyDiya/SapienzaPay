import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sapienzapay/lib2/deadlines.dart'; //Check with Eden
import 'package:sapienzapay/profile.dart';
//material contains predefined widgets and themes

void main() {
  runApp(const MyApp());
} //this starts the flutter app

class MyApp extends StatelessWidget {  //it's IMMUTABLE
  const MyApp({super.key}); //constructor with a key parameter to identify the widget in the tree

  @override
  Widget build(BuildContext context) { //method that returns a MaterialApp widget (root of app)
    return MaterialApp(
      title: 'SapienzaPay',
      theme: ThemeData(
        // ignore: prefer_const_constructors
        primaryColor: Color.fromARGB(255, 111, 20, 28)
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget { //mutable widget
  const HomePage({super.key}); //constructors are obj initializators for a class

  @override
  HomePageState createState() => HomePageState(); //=> means "return instance of"
}

class HomePageState extends State<HomePage> { //extends hp but keeps in consideration its state
  int _selectedIndex = 0; //currently selected tab
  final List<GlobalKey<PullUpListWidgetState>> _keys = [
    GlobalKey<PullUpListWidgetState>(),
    GlobalKey<PullUpListWidgetState>(),
    GlobalKey<PullUpListWidgetState>()
  ]; //_keys keeps globalkey instances for each pulluplistwidget to identify them uniquely and access their states

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //triggers a rebuild with setState to change the state of currently selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //user greeting
            // ignore: prefer_const_constructors
            Padding(
              padding: const EdgeInsets.all(16.0),
              // ignore: prefer_const_constructors
              child: Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'Hi, Firdaous!', //modify to take parameter from acc creation time. will remove const
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          //0ther buttons
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red[100],
                    backgroundColor: Colors.grey[400],
                  ),
                  onPressed: () {},
                  child: const Text('Uni Bank Account'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.red[100],
                    backgroundColor: Colors.grey[400],
                  ),
                  onPressed: () {},
                  child: const Text('All cards'),
                ),
              ],
            ),
          ),
          //ACC BALANCE
          Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  // ignore: prefer_const_constructors
                  color: Color.fromARGB(255, 111, 20, 28),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'UNI BANK ACCOUNT BALANCE',
                      style: TextStyle(color: Colors.grey[50], fontSize: 16),
                    ),
                    // ignore: prefer_const_constructors
                    const SizedBox(height:8.0),
                    Text(
                      'Card **** **** **** 1234',
                      style: TextStyle(color: Colors.grey[50], fontSize: 16),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'E 1800,00',
                      style: TextStyle(color: Colors.grey[50], fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '08/2025',
                      style: TextStyle(color: Colors.grey[50], fontSize: 16),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 16,
                right: 16,
                child: ElevatedButton(
                  onPressed: () {
                    //MONEY LOGIC TO BE ADDED
                  },
                  child: const Text('Add money'),
                  ),
                ),
              ],
            ),
          //TRANSACTIONS
            Padding(
              padding:const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Last Transactions',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {
                      _keys[_selectedIndex].currentState?.scrollToTop();
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.red[300],
              child: _selectedIndex == 0
                ? PullUpListWidget(key: _keys[_selectedIndex], text: 'Home')
                :(_selectedIndex == 1
                  ? DeadlinesPage(key: _keys[_selectedIndex])
                  : ProfilePage(key: _keys[_selectedIndex])),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.house_fill),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'Deadlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // ignore: prefer_const_constructors
        selectedItemColor: Color.fromARGB(255, 111, 20, 28),
        onTap: _onItemTapped,
      ),
    );
  }
} //WHAT IS A SCAFFOLD?

class PullUpListWidget extends StatefulWidget { 
  final String text; //Text is a parameter

  const PullUpListWidget({super.key, required this.text});

  @override
  PullUpListWidgetState createState() => PullUpListWidgetState();
}

class PullUpListWidgetState extends State<PullUpListWidget> {
  late List<String> items; //list of strs to display
  bool filterUniversityTransfers = false; //filter toggle
  final ScrollController _scrollController = ScrollController(); //automatic? control on scrolling the list

  @override
  void initState() { //initialises list containing items
    super.initState();
    items = List.generate(6, (index) => '${widget.text} Item $index');
  }

  void filterList() {
    setState(() {
      filterUniversityTransfers = !filterUniversityTransfers;
      if (filterUniversityTransfers) {
        items = items.where((item) => item.contains('University Transfer')).toList();
      } else {
        items = List.generate(6, (index) => '${widget.text} Item $index');
      }
    });
  }

  void scrollToTop() { //supposedly the method for opening the list to the whole page, but
    _scrollController.animateTo( //I think it will just scroll to the top of the list
      0.0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: filterList,
                child: const Text('University'),
              ),
              ElevatedButton(
                onPressed: filterList,
                child: const Text('All'),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.red[100],
                  child: const Icon(Icons.payment, color: Colors.white),
                  ),
                  title: Text(items[index]),
                  subtitle: Text('Date: ${(DateTime.now().subtract(Duration(days:index*2))).toString().split(' ')[0]}'),
                  trailing: Text(
                  index % 2 == 0 ? 'E 100.00' : 'E -50.00',
                  style: TextStyle(color: index % 2 == 0 ? Colors.green : Colors.red),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => DetailPage(item: items[index]),
                      ),
                    );
                  },
                );
            },
          ),
        ),
      ],
    );
  }
}

class DetailPage extends StatelessWidget {
  final String item; //the text to display

  const DetailPage({required this.item, super.key});
//WHAT IS REQUIRED???
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //LOOK UP APPBAR
        title: const Text('Detail page'),
      ),
      body: Center( //centers text
        child: Text('Details of $item'),
      ),
    );
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text; //prefix for each item (WHY???)

  const PlaceholderWidget(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 40,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('$text Item $index'),
        );
      },
    );
  }
}
