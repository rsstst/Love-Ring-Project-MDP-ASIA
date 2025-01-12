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
        filteredList = []; // TODO: Kosongkan hasil jika query kosong
      });
    } else {
      final results = userList.values
          .where((user) =>
              user.nama.isNotEmpty &&
              user.nama[0].toLowerCase() == query.toLowerCase())
          .toList();
      setState(() {
        filteredList = results; // TODO: Perbarui daftar hasil
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
            // TODO: Menambahkan background dengan lingkaran-lingkaran
            const CircleBackground(),
            // Scrollable area untuk konten utama
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
                        ? Center(
                            child: Text(
                              searchController.text.isEmpty
                                  ? ''
                                  : 'User Not Found', // TODO: Pesan jika tidak ada hasil pencarian
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
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
                                    // TODO: Navigasi ke halaman detail pengguna saat item diklik
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
  const CircleBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          left: MediaQuery.of(context).size.width * 0.1,
          child: CircleWidget(radius: 50, color: Colors.blue.withOpacity(0.3)),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          right: MediaQuery.of(context).size.width * 0.15,
          child: CircleWidget(
              radius: 30, color: Colors.redAccent.withOpacity(0.8)),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.25,
          left: MediaQuery.of(context).size.width * 0.2,
          child: CircleWidget(radius: 60, color: Colors.blue.withOpacity(0.7)),
        ),
        Positioned(
          bottom: MediaQuery.of(context).size.height * 0.3,
          right: MediaQuery.of(context).size.width * 0.25,
          child:
              CircleWidget(radius: 20, color: Colors.purple.withOpacity(0.4)),
        ),
      ],
    );
  }
}

class CircleWidget extends StatelessWidget {
  final double radius;
  final Color color;

  const CircleWidget({super.key, required this.radius, required this.color});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: color,
    );
  }
}
