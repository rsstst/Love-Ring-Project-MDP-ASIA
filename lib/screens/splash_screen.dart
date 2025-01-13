import 'package:flutter/material.dart';
import 'package:pr_mobile_mdp/screens/home_screen.dart';
import 'dart:async';
import 'package:pr_mobile_mdp/screens/login_screen.dart';

class SplashScreen extends StatelessWidget {
  final bool isLoggedIn;
  const SplashScreen({super.key,required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
      if (isLoggedIn) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()), 
        ); 
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()), 
        ); 
      }
    });

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/back ground.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Image.asset(
              'images/logo.png',
              width: 300,
              height: 300,
            )
          )
        ]
      ),
    );
  }
}