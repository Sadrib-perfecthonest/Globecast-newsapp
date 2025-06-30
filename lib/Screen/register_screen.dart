import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? usersJson = prefs.getString('registeredUsers');
      List<Map<String, String>> registeredUsers = [];

      if (usersJson != null) {
        registeredUsers = List<Map<String, String>>.from(
          (jsonDecode(usersJson) as List).map(
            (item) => Map<String, String>.from(item as Map),
          ),
        );
      }

      if (registeredUsers.any((user) => user['email'] == email)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email already registered on this device.')),
        );
        return;
      }

      registeredUsers.add({'email': email, 'password': password});

      await prefs.setString('registeredUsers', jsonEncode(registeredUsers));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful! Please login.')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred during registration: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register",
          style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).appBarTheme.titleTextStyle?.color),
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Create Account",
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.titleLarge?.color),
            ),
            SizedBox(height: 40),
            TextField(
              controller: _emailController,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _confirmPasswordController,
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium?.color),
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).dividerColor),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),
            _isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary)
                : ElevatedButton(
                    onPressed: _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
