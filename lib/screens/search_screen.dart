import 'package:flutter/material.dart';
import 'package:pr_mobile_mdp/models/user.dart';
import 'package:pr_mobile_mdp/data/user_data.dart';

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
      final results = userList
          .where((user) =>
              user.nama.isNotEmpty &&
              user.nama[0].toLowerCase() == query.toLowerCase())
          .toList();
      setState(() {
        filteredList = results;
      });
    }
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
                    // TODO: Input pencarian untuk mencari pengguna
                    TextField(
                      controller: searchController,
                      onChanged: (value) {
                        filterSearch(
                            value); // TODO: Panggil filterSearch saat input berubah
                      },
                      decoration: InputDecoration(
                        hintText:
                            'Search Crush', // TODO: Ubah teks hint sesuai kebutuhan
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // TODO: Menampilkan hasil pencarian atau pesan jika tidak ada hasil
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
                                    fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: filteredList.length,
                            itemBuilder: (context, index) {
                              final user = filteredList[index];
                              return Card(
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(user
                                        .profil), // TODO: Menampilkan foto profil pengguna
                                  ),
                                  title: Text(user
                                      .nama), // TODO: Menampilkan nama pengguna
                                  subtitle: Text(user
                                      .loc), // TODO: Menampilkan lokasi pengguna
                                  trailing: const Icon(Icons
                                      .favorite_border), // TODO: Ikon favorit
                                  onTap: () {
                                    // TODO: Navigasi ke halaman detail pengguna
                                  },
                                ),
                              );
                            },
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
