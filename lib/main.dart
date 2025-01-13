import 'package:flutter/material.dart';

import 'package:mdp_gacoan/screens/Home_screen.dart';
import 'package:mdp_gacoan/screens/Login_screen.dart';
import 'package:mdp_gacoan/screens/crush_screen.dart';
import 'package:mdp_gacoan/screens/edit_screen.dart';
import 'package:mdp_gacoan/screens/main_screen.dart';
import 'package:mdp_gacoan/screens/more_screen.dart';
import 'package:mdp_gacoan/screens/search_screen.dart';
import 'package:mdp_gacoan/screens/setting_screen.dart';
import 'package:mdp_gacoan/screens/signup_screen.dart';
import 'package:mdp_gacoan/screens/splash_screen.dart';


import 'package:shared_preferences/shared_preferences.dart';

void main() async {
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
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue)),
        home: SplashScreen(isLoggedIn: isLoggedIn),
        routes: {
          '/main': (context) => const MainScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/setting': (context) => const SettingScreen(),
          '/edit': (context) => const EditScreen(),
          '/search': (context) => const SearchScreen(),
          '/more': (context) => const MoreScreen(),
          '/crush': (context) => const CrushScreen(),
        });
  }
}
