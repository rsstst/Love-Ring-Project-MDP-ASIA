import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'crush_screen.dart';
import 'package:mdp_gacoan/models/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({required this.user});

  Future<void> addCrush(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedCrushList = prefs.getStringList('crushList') ?? [];

    // Data crush yang akan ditambahkan
    Map<String, dynamic> crushData = {
      "name": user.nama,
      "loc": user.loc,
      "image": user.profil,
      "likes": 1
    };

    // Cek apakah crush sudah ada di daftar
    bool alreadyAdded = savedCrushList.any((item) {
      final decodedItem = jsonDecode(item);
      return decodedItem['name'] == user.nama;
    });

    if (alreadyAdded) {
      // Tampilkan pesan peringatan jika crush sudah ada
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${user.nama} is already in your Crush List!')),
      );
    } else {
      // Tambahkan crush jika belum ada
      savedCrushList.add(jsonEncode(crushData));
      await prefs.setStringList('crushList', savedCrushList);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${user.nama} added to Crush List!')),
      );

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => CrushScreen()),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.nama,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(user.profil),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'ID: ${user.Id}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.account_circle, color: Color.fromARGB(255, 129, 88, 206)),
                  SizedBox(width: 8),
                  Text(
                    user.nama,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Color.fromARGB(255, 129, 88, 206)),
                  SizedBox(width: 8),
                  Text(
                    user.loc,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                user.desc,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    addCrush(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 129, 88, 206),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Add Crush',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(width: 8),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
