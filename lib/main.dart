import 'package:flutter/material.dart';
import 'package:pr_mobile_mdp/screens/Home_screen.dart';
import 'package:pr_mobile_mdp/screens/Login_screen.dart';
import 'package:pr_mobile_mdp/screens/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MainApp(isLoggedIn: isLoggedIn));
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: 
      ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
    home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    routes : {
      '/login':(context) =>const LoginScreen(),
      '/signup':(context)=>const SignupScreen(),
      '/home':(context)=>const HomeScreen()
    }
    );
  }
}