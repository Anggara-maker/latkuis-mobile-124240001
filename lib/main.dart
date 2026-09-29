import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const GacoanApp());
}

class GacoanApp extends StatelessWidget {
  const GacoanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gacoan Menu',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8F8),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE21B23),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF222222),
          elevation: 0,
        ),
      ),
      home: const LoginScreen(),
    );
  }
}