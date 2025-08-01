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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text('Dark Mode', style: GoogleFonts.poppins(fontSize: 18)),
            value: _isDarkMode,
            onChanged: _toggleTheme,
            secondary: Icon(Icons.brightness_6),
          ),
          ListTile(
            title: Text(
              'App Details',
              style: GoogleFonts.poppins(fontSize: 18),
            ),
            leading: Icon(Icons.info_outline),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: 'HeadlineHub',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 HeadlineHub. All rights reserved.',
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'This app provides the latest news headlines from various sources.',
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
              );
            },
          ),
          ListTile(
            title: Text(
              'Logout',
              style: GoogleFonts.poppins(fontSize: 18, color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: _logout,
          ),
        ],
      ),
    );
  }
}
