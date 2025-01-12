import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CrushScreen extends StatefulWidget {
  const CrushScreen({super.key});

  @override
  State<CrushScreen> createState() => _CrushScreenState();
}

class _CrushScreenState extends State<CrushScreen> {
  final List<Map<String, dynamic>> crushList = [
    {
      "name": "Reza Arab",
      "image": "assets/reza.jpg",
      "code": "4E0987H",
      "likes": 988,
    },
    {
      "name": "Arya Mohan",
      "image": "assets/mohan.jpg",
      "code": "9B676Y2",
      "likes": 37,
    },
    {
      "name": "Heri Putra",
      "image": "assets/heri.jpg",
      "code": "7A445ZG7",
      "likes": 154,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("My Crush"),
        backgroundColor: Colors.blue.shade600,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: crushList.length,
          itemBuilder: (context, index) {
            final crush = crushList[index];
            return buildCrushCard(crush);
          },
        ),
      ),
    );
  }

  Widget buildCrushCard(Map<String, dynamic> crush) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(crush["image"]),
              radius: 40,
            ),
            const SizedBox(height: 16),
            Text(
              crush["name"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Code: ${crush["code"]}",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.favorite, color: Colors.pinkAccent),
                const SizedBox(width: 4),
                Text(
                  "${crush["likes"]}",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                print('${crush["name"]} uncrushed');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "UNCRUSH",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
