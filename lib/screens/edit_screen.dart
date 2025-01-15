import 'package:flutter/material.dart';
import 'package:mdp_gacoan/data/user_data.dart'; 
import 'package:mdp_gacoan/models/user.dart'; 
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String username = '';
  String description = '';
  String profil = '';

  // Controllers to handle text fields
  late TextEditingController nameController;
  late TextEditingController descriptionController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    _loadUserData();
  }

  _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedUsername = prefs.getString('username');

    if (storedUsername != null) {
      setState(() {
        username = storedUsername;
        User? user = userList[username];
        profil = user?.profil ?? '';
        description = user?.desc ?? '';
        nameController.text = username;
        descriptionController.text = description;
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF), 
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            // Profile Picture with Heart Icon
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 5,
                            ),
                            shape: BoxShape.circle
                          ),
                          child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(profil),
                          ),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: const [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.black,
                              size: 30,
                              ),
                            Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 20, // Ukuran lebih kecil untuk ikon hati
                            ),
                          ],
                        ),
                ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.edit, color: Color(0xFFE1D0E1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF7F4FA),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Description',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                suffixIcon: const Icon(Icons.edit, color: Color(0xFFE1D0E1)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF7F4FA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
