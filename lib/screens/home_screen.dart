import 'package:flutter/material.dart';
import 'package:pr_mobile_mdp/data/user_data.dart';
import 'package:pr_mobile_mdp/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = '';
  String Id = '4N01MS5';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');
    
    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
        User? user = userList[username];
        Id = user?.Id ?? 'Unknown ID';
      });
    }
  }

  void _showActivateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            margin: const EdgeInsets.only(top: 30), 
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF6E44FF), // Warna ungu
              borderRadius: BorderRadius.circular(16),
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Do you want to activate the radar?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please activate your location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); 
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Got it',
                    style: TextStyle(
                      color: Color(0xFF6E44FF), // Warna ungu
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F3FF), // Warna ungu muda
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Heart ID',
              style: TextStyle(
                color: Color(0xFF6E44FF), // Warna ungu
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              //TODO : ambil data 
              Id,
              style: TextStyle(
                color: Color(0xFF6E44FF), // Warna ungu
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.favorite_outline,
                color: Color(0xFF6E44FF), // Warna ungu
              ),
              Text(
                '128',
                style: TextStyle(
                  color: Color(0xFF6E44FF), // Warna ungu
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lingkaran-lingkaran konsentris
            Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.blue.shade100.withOpacity(0.2),
                ),
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue.shade100.withOpacity(0.4),
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.blue.shade100.withOpacity(0.6),
                ),
                const Icon(Icons.favorite, color: Colors.pink, size: 40),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _showActivateDialog(context);
              },
              child: const Text('Activate'),
            ),
          ],
        ),
      ),
    );
  }
}
