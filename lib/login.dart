import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'deadline_parent.dart';

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
        primaryColor: Color.fromARGB(255, 130, 36, 61),
      ),
      home: const InitialLoginPage(),
    );
  }
}

class InitialLoginPage extends StatelessWidget {
  const InitialLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Color.fromARGB(255, 130, 36, 61),
            height: MediaQuery.of(context).size.height * 0.25, // Reduced height
            child: Center(
              child: ClipOval(
                child: Image.asset(
                  'assets/logo.png',
                  width: 90,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 35),
          Text(
            '  Welcome to \n SapienzaPay',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(1000, 130, 36, 61),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Make your uni life easier!',
            style: TextStyle(
              fontSize: 20,
              color: CupertinoColors.systemGrey,
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '    I am...',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(1000, 130, 36, 61),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ParentLoginPage()),
                  );
                },
                child: Text('Parent',
                  style: TextStyle(
                    fontSize: 22, // Increased font size
                    fontWeight: FontWeight.normal
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Increased size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: Text('Student',
                  style: TextStyle(
                    fontSize: 22, // Increased font size
                    fontWeight: FontWeight.normal
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Increased size
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 200),
        ],
      ),
    );
  }
}

class ParentLoginPage extends StatefulWidget {
  const ParentLoginPage({super.key});

  @override
  _ParentLoginPageState createState() => _ParentLoginPageState();
}

class _ParentLoginPageState extends State<ParentLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _studentIdController = TextEditingController();


  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Column(
          children: [
            Container(
              color: Color.fromARGB(255, 130, 36, 61),
              height: MediaQuery.of(context).size.height * 0.20, // Reduced height
            ),
            SizedBox(height: 60), // Adjust this value if needed for spacing
            Text(
              'Parent Login',
              style: TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 130, 36, 61),
              ),
            ),
            SizedBox(height: 0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _studentIdController,
                      decoration: InputDecoration(labelText: 'Student ID'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your student\'s ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 25),
                    OutlinedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const DeadlinesPage()),
                          );
                        }
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 20),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: BorderSide(color: Colors.grey),
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15), // Increased size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            SizedBox(height: 20),
          ],
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.18 - 50, // Adjust the top value to overlap
          left: MediaQuery.of(context).size.width / 2 - 45, // Adjust to center horizontally
          child: ClipOval(
            child: Image.asset(
              'assets/logo.png',
              width: 90,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 50,
          left: 1,
          child: IconButton(
            iconSize: 35,
            icon: Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ],
    ),
  );
}
}
