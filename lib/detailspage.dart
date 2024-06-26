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
      //title: 'sapienzapay';
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
//final or static stuff and methods to apply for parts of the page

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Placeholder() //build the page here
    );
  }
}
