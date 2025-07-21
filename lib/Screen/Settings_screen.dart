import 'package:flutter/material.dart';
import 'package:globecastnewsapp/Screen/login_screen.dart';
import 'package:globecastnewsapp/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
    required Null Function(ThemeMode themeMode) updateThemeMode,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemeSetting();
  }

  Future<void> _loadThemeSetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode =
          (prefs.getInt('themeMode') ?? ThemeMode.system.index) ==
          ThemeMode.dark.index;
    });
  }

  Future<void> _toggleTheme(bool value) async {
    setState(() {
      _isDarkMode = value;
    });
    MyApp.of(
      context,
    ).setThemeMode(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
