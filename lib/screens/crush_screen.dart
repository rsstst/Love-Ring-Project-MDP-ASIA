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
    List<String>? savedCrushList = prefs.getStringList('crushList');

    if (savedCrushList != null) {
      try {
        setState(() {
          crushList = savedCrushList
              .map((item) => jsonDecode(item) as Map<String, dynamic>)
              .toList();
        });
      } catch (e) {
        print("Error decoding crush list: $e");
      }
    } else {
      setState(() {
        crushList = [];
      });
    }
  }

  Future<void> saveCrushList() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> encodedList =
        crushList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('crushList', encodedList);
  }

  Future<void> removeCrush(Map<String, dynamic> crush) async {
    setState(() {
      crushList.remove(crush);
    });

    final prefs = await SharedPreferences.getInstance();
    List<String> updatedList =
        crushList.map((item) => jsonEncode(item)).toList();
    await prefs.setStringList('crushList', updatedList);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${crush["name"]} removed from Crush List!')),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("My Crush"),
      backgroundColor: Colors.blue.shade600,
      centerTitle: true, // Memposisikan judul di tengah
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context); // Navigasi kembali ke halaman sebelumnya
        },
      ),
    ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: crushList.isEmpty
                  ? const Center(
                      child: Text("No Crushes Yet"),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(), // Membantu scroll secara fleksibel
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 3,
                          childAspectRatio: 0.50, // Sesuaikan rasio child untuk mencegah overflow
                        ),
                        itemCount: crushList.length,
                        itemBuilder: (context, index) {
                          final crush = crushList[index];
                          return buildCrushCard(crush);
                        },
                      ),
                    ),
            ),
          ],
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ClipOval(
              child: Image.asset(
                crush["image"],
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              crush["name"],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              crush["loc"],
              style: const TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
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
            const SizedBox(height: 2),
            ElevatedButton(
              onPressed: () {
                removeCrush(crush);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade600,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                "UNCRUSH",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
