import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CrushScreen extends StatefulWidget {
  const CrushScreen({super.key});

  @override
  State<CrushScreen> createState() => _CrushScreenState();
}

class _CrushScreenState extends State<CrushScreen> {
  List<Map<String, dynamic>> crushList = [];

  @override
  void initState() {
    super.initState();
    loadCrushList();
  }

  Future<void> loadCrushList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedCrushList = prefs.getStringList('crushList') ?? [];
    setState(() {
      crushList = savedCrushList
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
    });
  }

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
      body: crushList.isEmpty
          ? const Center(
              child: Text("No Crushes Yet"),
            )
          : Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
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
              crush["loc"],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
