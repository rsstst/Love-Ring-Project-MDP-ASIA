import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mdp_gacoan/models/user.dart';
import 'package:mdp_gacoan/data/user_data.dart';
import 'package:mdp_gacoan/screens/detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<User> filteredList = [];
  TextEditingController searchController = TextEditingController();

  void filterSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = [];
      });
    } else {
      final results = userList.values
          .where((user) =>
              user.nama.isNotEmpty &&
              user.nama.toLowerCase().contains(query.toLowerCase()))
          .toList();
      results.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
      setState(() {
        filteredList = results;
      });
    }
  }

  Future<void> addToCrushList(User user) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> crushList = prefs.getStringList('crushList') ?? [];

  // Cek apakah user sudah ada dalam daftar crush
  bool alreadyAdded = crushList.any((item) {
    final decodedItem = jsonDecode(item);
    return decodedItem["name"] == user.nama;
  });

  if (alreadyAdded) {
    // Tampilkan pesan peringatan jika user sudah ada dalam daftar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${user.nama} is already in your crush list!")),
    );
  } else {
    // Tambahkan user ke daftar crush jika belum ada
    crushList.add(jsonEncode({
      "name": user.nama,
      "image": user.profil,
      "loc": user.loc,
      "likes": 1,
    }));

    await prefs.setStringList('crushList', crushList);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${user.nama} added to crush list!")),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Visibility(
              visible: filteredList.isEmpty,
              child: const CircleBackground(),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Text(
                          'Search for New Crush',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TextField(
                      controller: searchController,
                      onChanged: filterSearch,
                      decoration: InputDecoration(
                        hintText: 'Search Crush',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    filteredList.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 300),
                              Text(
                                searchController.text.isEmpty
                                    ? ''
                                    : 'User Not Found',
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: filteredList.map((user) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailScreen(user: user),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFB0B0B0),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          backgroundImage:
                                              AssetImage(user.profil),
                                          radius: 40,
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                user.nama,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                user.loc,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.favorite_border),
                                          onPressed: () {
                                            addToCrushList(user);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleBackground extends StatelessWidget {
  const CircleBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircleAvatar(
            radius: 100,
            backgroundColor: const Color(0xFFBBDEFB).withAlpha(51),
          ),
          CircleAvatar(
            radius: 80,
            backgroundColor: const Color(0xFFBBDEFB).withAlpha(102),
          ),
          CircleAvatar(
            radius: 60,
            backgroundColor: const Color(0xFFBBDEFB).withAlpha(153),
          ),
          const Icon(
            Icons.search_rounded,
            color: Color(0xFF000080),
            size: 40,
          ),
        ],
      ),
    );
  }
}
