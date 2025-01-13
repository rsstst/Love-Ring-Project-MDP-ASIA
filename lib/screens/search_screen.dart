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
  // TODO: Daftar hasil pencarian
  List<User> filteredList = [];
  // TODO: Controller untuk input pencarian
  TextEditingController searchController = TextEditingController();

  // TODO: Fungsi untuk memfilter pencarian berdasarkan huruf depan nama
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
      results
          .sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
      setState(() {
        filteredList = results;
      });
    }
  }

  Future<void> addToCrushList(User user) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> crushList =
        prefs.getStringList('crushList') ?? []; // Ambil daftar crush

    // Tambahkan user ke crushList
    crushList.add(jsonEncode({
      "name": user.nama,
      "image": user.profil,
      "loc": user.loc,
      "likes": 1,
    }));

    // Simpan daftar crush yang diperbarui
    await prefs.setStringList('crushList', crushList);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${user.nama} added to crush list!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search for New Crush'),
        titleTextStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
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
                    // Search input field
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterSearch(value);
                      },
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
                              SizedBox(height: 300),
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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    // TODO: Navigasi ke halaman detail pengguna saat item diklik
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
                                          color: Colors.grey.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
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
                                          icon:
                                              const Icon(Icons.favorite_border),
                                          onPressed: () {
                                            // Navigate to the CrushScreen when favorite icon is pressed
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
          const Icon(
            Icons.search_rounded,
            color: Colors.black,
            size: 40,
          ),
        ],
      ),
    );
  }
}
