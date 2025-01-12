import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isChecked = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Icon
              IconButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
              ),

              // Spacer for Logo/Icon
              const SizedBox(height: 16),
              // Centered Logo/Icon
              Center(
                child: Icon(
                  Icons.location_on_outlined,
                  size: 80,
                  color: Colors.purple.shade200,
                ),
              ),

              const SizedBox(height: 24),

              // Header Text
              const Center(
                child: Text(
                  "Nice to see you!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Username Field
              TextField(
                decoration: InputDecoration(
                    labelText: "Enter your username",
                    labelStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon:
                        const Icon(Icons.person_outline, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    )),
              ),
              const SizedBox(height: 16),

              // Email Field
              TextField(
                decoration: InputDecoration(
                    labelText: "Enter your email address",
                    labelStyle: TextStyle(color: Colors.grey.shade500),
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    )),
              ),
              const SizedBox(height: 16),

              // Age Field
              _buildTextField(
                labelText: "Enter your age",
                prefixIcon: Icons.calendar_today_outlined,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),

              //gender Field
              _buildTextField(
                labelText: "Gender",
                prefixIcon: Icons.person,
                suffixIcon: DropdownButton<String>(
                  value: _selectedGender,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  items: <String>['Male', 'Female', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password Field
              // TextField(
              //   decoration: InputDecoration(
              //       labelText: "Enter your password",
              //       labelStyle: TextStyle(color: Colors.grey.shade500),
              //       filled: true,
              //       fillColor: Colors.grey.shade200,
              //       prefixIcon:
              //           const Icon(Icons.lock_outline, color: Colors.grey),
              //       suffixIcon: IconButton(
              //           icon: Icon(_isPasswordVisible
              //               ? Icons.visibility
              //               : Icons.visibility_off),
              //           color: Colors.grey,
              //           onPressed: () {
              //             setState(() {
              //               _isPasswordVisible = !_isPasswordVisible;
              //             });
              //           }),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(8),
              //         borderSide: BorderSide.none,
              //       )),
              // ),
              _buildTextField(
                labelText: "Enter your password",
                prefixIcon: Icons.lock_outline,
                obscureText: !_isPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),

              // Re-type Password Field
              _buildTextField(
                labelText: "Re-type your password",
                prefixIcon: Icons.lock_outline,
                obscureText: !_isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Checkbox and Terms & Conditions
              Row(
                children: [
                  Checkbox(
                    value: _isChecked,
                    activeColor: Colors.blue,
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    "I agree with ",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle Terms & Conditions navigation
                    },
                    child: const Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Continue Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue logic
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable TextField Widget
  Widget _buildTextField({
    required String labelText,
    IconData? prefixIcon,
    Widget? suffixIcon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade200,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
