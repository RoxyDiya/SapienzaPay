import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'home_page.dart';
import 'package:flutter/cupertino.dart';
import 'deadlines.dart';
import 'utils.dart';
import 'profile_stud.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 111, 20, 28)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
