import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),

              // Profile Picture
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage('https://i.pinimg.com/550x/b0/0e/36/b00e36dac290fa0e34db0a40a23c7d53.jpg'),
                ),
              ),

              const SizedBox(height: 16),

              // Name and Heart ID
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Aleena Calista Gabriella',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF233C7B), // Dark blue color
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Heart ID : D41W615',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Description
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Aku seorang gadis berusia 21 tahun. Asal Surabaya tapi sekarang lagi tinggal di Palembang. Aku sangat menyukai olahraga, terutama berlari dan voli.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Edit Profile Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/edit');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            color: Color(0xFF6F3DD2),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Edit Profile',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6F3DD2),
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Settings Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/setting');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            color: Color(0xFF6F3DD2),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color(0xFF6F3DD2),
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
