import 'package:flutter/material.dart';
import 'package:mdp_gacoan/data/user_data.dart';
import 'package:mdp_gacoan/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  String username = '';
  String Id = '4N01MS5';
  late AnimationController _controller;
  late Animation<double> _circleAnimation1;
  late Animation<double> _circleAnimation2;
  late Animation<double> _circleAnimation3;
  late Animation<double> _circleAnimation4;
  late Animation<double> _circleAnimation5;
  late Animation<double> _heartBeatAnimation;


  @override
  void initState() {
    super.initState();
    _loadUserData();

        // Animasi Controller
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Animasi Lingkaran
    _circleAnimation1 = Tween<double>(begin: 0.0, end: 150.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _circleAnimation2 = Tween<double>(begin: 0.0, end: 200.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _circleAnimation3 = Tween<double>(begin: 0.0, end: 250.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _circleAnimation4 = Tween<double>(begin: 0.0, end: 300.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _circleAnimation5 = Tween<double>(begin: 0.0, end: 350.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Animasi Detak Jantung
    _heartBeatAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        automaticallyImplyLeading: false,
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
            // Lingkaran-lingkaran
            Stack(
              alignment: Alignment.center,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    width: _circleAnimation5.value,
                    height: _circleAnimation5.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100.withOpacity(0.2),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    width: _circleAnimation4.value,
                    height: _circleAnimation4.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100.withOpacity(0.3),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    width: _circleAnimation3.value,
                    height: _circleAnimation3.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100.withOpacity(0.4),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    width: _circleAnimation2.value,
                    height: _circleAnimation2.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100.withOpacity(0.5),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) => Container(
                    width: _circleAnimation1.value,
                    height: _circleAnimation1.value,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade100.withOpacity(0.6),
                    ),
                  ),
                ),
                AnimatedBuilder(
                  animation: _heartBeatAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: _heartBeatAnimation.value,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.pink,
                      size: 40,
                    ),
                  ),
                ),
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
