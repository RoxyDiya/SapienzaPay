import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class DeadlinesPage extends StatefulWidget {
  const DeadlinesPage({super.key});

  @override
  _DeadlinesPageState createState() => _DeadlinesPageState();
}

class _DeadlinesPageState extends State<DeadlinesPage> {
  //put some bools or constants for the selection action

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Deadlines'),
      ),
      body: Padding(
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
              Text('2023', //change to take from the deadline info if you plan to have a database where you insert deadlines
                style: TextStyle(color: Colors.grey, fontSize: 20)
              ),
              SizedBox(height:10),
              Placeholder(fallbackHeight: 100), //LIST OF UPCOMING TAXES AS LIGHT RED BUTTONS
              SizedBox(height:10),
              Text(
                'UPCOMING',
                style: TextStyle(fontSize: 24, color: Color.fromARGB(255, 111, 20,28))
              ),
              SizedBox(height:20),
              Text(
                '2024',
                style: TextStyle(color: Colors.grey, fontSize: 20)
              ),
              SizedBox(height:10),
              Placeholder(fallbackHeight: 100),
              SizedBox(height:20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    //navigation action
                  },
                  child: const Text('Pay Now'),
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
    );
  }
}
