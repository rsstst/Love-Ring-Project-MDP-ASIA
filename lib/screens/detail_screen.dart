import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'crush_screen.dart'; // Import CrushScreen
import 'package:mdp_gacoan/models/user.dart';

class DetailScreen extends StatelessWidget {
  final User user;

  DetailScreen({required this.user});

  Future<void> addCrush(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? savedCrushList = prefs.getStringList('crushList') ?? [];

    // Convert User to Map
    Map<String, dynamic> crushData = {
      "name": user.nama,
      "loc": user.loc,
      "image": user.profil,
      "likes": 7 // Add default likes value
    };

    // Add new crush
    savedCrushList.add(jsonEncode(crushData));

    // Save updated list to shared preferences
    await prefs.setStringList('crushList', savedCrushList);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${user.nama} added to Crush List!')),
    );

    // Navigate back to CrushScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CrushScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Profile'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60, // Increased radius
                  backgroundImage: NetworkImage(user.profil),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.person, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    user.nama,
                    style: TextStyle(fontSize: 18), // Non-bold font
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.home, color: Colors.blue),
                  SizedBox(width: 8),
                  Text(
                    user.loc,
                    style: TextStyle(fontSize: 16), // Non-bold font
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                'Description',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Larger and bold
              ),
              SizedBox(height: 8),
              Text(
                user.desc,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16),
              ),
              Spacer(),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    addCrush(context);
                  },
                  icon: Icon(Icons.favorite_border),
                  label: Text('Add Crush'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent, 
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12), // Longer button
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textStyle: TextStyle(
                      color: Colors.white, // Text color that complements the button color
                    ),
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
