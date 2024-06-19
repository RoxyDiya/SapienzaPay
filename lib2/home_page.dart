import 'package:flutter/material.dart';
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

  final List<Widget> _widgetOptions = <Widget>[
    PullUpListWidget(key: GlobalKey<PullUpListWidgetState>(), text: 'Home'),
    PullUpListWidget(key: GlobalKey<PullUpListWidgetState>(), text: 'Deadlines'),
    PullUpListWidget(key: GlobalKey<PullUpListWidgetState>(), text: 'Profile'),
  ]; //_widgetOptions = list of the widgets to display for every tab 


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //triggers a rebuild with setState to change the state of currently selected tab

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SapienzaPay'),
        actions: [
          TextButton(
            onPressed: () {
              _keys[_selectedIndex].currentState?.scrollToTop();
            },
            child: const Text(
              'View all',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // BUTTONS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Uni Bank account'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('All cards'),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Account balance:'),
          ),
          // PULLUP LIST
          Expanded(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Deadlines',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
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
    items = List.generate(20, (index) => '${widget.text} Item $index');
  }

  void filterList() {
    setState(() {
      filterUniversityTransfers = !filterUniversityTransfers;
      if (filterUniversityTransfers) {
        items = items.where((item) => item.contains('University Transfer')).toList();
      } else {
        items = List.generate(20, (index) => '${widget.text} Item $index');
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
                child: const Text('University Transfers'),
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
                title: Text(items[index]),
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
