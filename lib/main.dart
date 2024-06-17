import 'package:flutter/material.dart';

void main() {
  runApp(SapienzaPayApp());
}

class SapienzaPayApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Color(0xFFD19BA0),
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/logo.png', // replace with your logo asset path
                      height: 80,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40),
            Text(
              'Welcome to\nSapienzaPay',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color(0xFF572D31),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Make your university life easier!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Spacer(),
            Text(
              'I am a....',
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFF572D31),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Color(0xFF572D31),
                    side: BorderSide(color: Color(0xFF572D31)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('STUDENT'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Color(0xFF572D31),
                    side: BorderSide(color: Color(0xFF572D31)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text('PARENT'),
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

