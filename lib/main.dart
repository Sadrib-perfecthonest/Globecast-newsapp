import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:globecastnewsapp/Screen/splash_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;
  bool _isLoggedIn = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettingsAndLoginStatus();
  }

  Future<void> _loadSettingsAndLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _themeMode =
          ThemeMode.values[prefs.getInt('themeMode') ?? ThemeMode.system.index];
      _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
      _isLoading = false;
    });
  }

  void setThemeMode(ThemeMode newThemeMode) {
    setState(() {
      _themeMode = newThemeMode;
    });
    _saveThemeSetting(newThemeMode);
  }

  Future<void> _saveThemeSetting(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', themeMode.index);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: ' GlobeCast ',
      // Light Theme
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          toolbarTextStyle: TextTheme(
            titleLarge: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleLarge: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(color: Colors.black),
          bodyLarge: GoogleFonts.poppins(color: Colors.black),
          titleMedium: GoogleFonts.poppins(color: Colors.black),
          titleLarge: GoogleFonts.poppins(color: Colors.black),
        ),
        cardColor: Colors.grey[100],
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          toolbarTextStyle: TextTheme(
            titleLarge: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).bodyMedium,
          titleTextStyle: TextTheme(
            titleLarge: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ).titleLarge,
        ),
        textTheme: TextTheme(
          bodyMedium: GoogleFonts.poppins(color: Colors.white),
          bodyLarge: GoogleFonts.poppins(color: Colors.white),
          titleMedium: GoogleFonts.poppins(color: Colors.white),
          titleLarge: GoogleFonts.poppins(color: Colors.white),
        ),
        cardColor: Colors.grey[900],
      ),
      themeMode: _themeMode,
      home: SplashScreen(updateThemeMode: (ThemeMode) {}),
    );
  }
}
