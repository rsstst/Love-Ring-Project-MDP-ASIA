import 'package:flutter/material.dart';

class CrushScreen extends StatefulWidget {
  const CrushScreen({super.key});

  @override
  State<CrushScreen> createState() => _CrushScreenState();
}

class _CrushScreenState extends State<CrushScreen> {
  final List<Map<String, dynamic>> crushList = [
    {
      "name": "Reza arab",
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
      appBar: AppBar(
        title: const Text("My Crush"),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.75,
          ),
          itemCount: crushList.length,
          itemBuilder: (context, index) {
            final crush = crushList[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(crush["image"]),
                    radius: 40,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    crush["name"],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text("Code: ${crush["code"]}"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite, color: const Color.fromARGB(255, 210, 115, 174)),
                      const SizedBox(width: 4),
                      Text("${crush["likes"]}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      // Tambahkan logika untuk tombol "UNCRUSH"
                      print('${crush["name"]} uncrushed');
                    },
                    child: const Text("UNCRUSH"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[200],  // Gunakan backgroundColor
                      foregroundColor: Colors.white,       // Gunakan foregroundColor untuk warna teks
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
