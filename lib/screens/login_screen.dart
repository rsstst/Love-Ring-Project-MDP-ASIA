import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                child: Column(
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(0, 32, 0, 0),
            child: (const Text('WELCOME FRIEND!',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
          ),
        ),
      ],
    ))));
  }
}
