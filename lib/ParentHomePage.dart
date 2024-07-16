import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'profile_par.dart';

class ParentHomePage extends StatefulWidget {
  const ParentHomePage({super.key});

  @override
  _ParentHomePageState createState() => _ParentHomePageState();
}

class _ParentHomePageState extends State<ParentHomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    DeadlinesView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SapienzaPay Parent'),
        backgroundColor: Color.fromARGB(255, 130, 36, 61),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Deadlines',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromARGB(255, 130, 36, 61),
        onTap: _onItemTapped,
      ),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile View',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

class DeadlinesView extends StatelessWidget {
  const DeadlinesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Deadlines View',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
