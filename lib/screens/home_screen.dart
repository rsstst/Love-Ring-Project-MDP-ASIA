import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Heart ID',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('D41W615'),
                SizedBox(width: 10),
                Icon(Icons.favorite, color: Colors.pink),
                Text('1238'),
              ],
            ),
            const SizedBox(height: 40),
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
                // Tambahkan logika untuk tombol "Activate" di sini
                print('Activate button pressed');
              },
              child: const Text('Activate'),
            ),
          ],
        ),
      ),
    );
  }
}
