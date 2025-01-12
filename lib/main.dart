import 'package:flutter/material.dart';
import 'package:pr_mobile_mdp/auth_gate.dart';

import 'package:pr_mobile_mdp/screens/Home_screen.dart';
import 'package:pr_mobile_mdp/screens/Login_screen.dart';
import 'package:pr_mobile_mdp/screens/edit_screen.dart';
import 'package:pr_mobile_mdp/screens/main_screen.dart';
import 'package:pr_mobile_mdp/screens/more_screen.dart';
import 'package:pr_mobile_mdp/screens/search_screen.dart';
import 'package:pr_mobile_mdp/screens/setting_screen.dart';
import 'package:pr_mobile_mdp/screens/signup_screen.dart';
import 'package:pr_mobile_mdp/screens/more_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pr_mobile_mdp/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
        home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
        routes: {
          '/main': (context) => const MainScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/setting': (context) => const SettingScreen(),
          '/edit': (context) => const EditScreen(),
          '/search': (context) => const SearchScreen(),
          '/more': (context) => const MoreScreen(),
        });
  }
}
