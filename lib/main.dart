import 'package:flutter/material.dart';
import 'package:projeto3/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      theme: meuTemaEscuro,
      home: LoginPage(),
    );
  }
}

final ThemeData meuTemaEscuro = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF0D1117),
  primaryColor: const Color(0xFF1F6FEB),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF1F6FEB),
    secondary: Color(0xFF58A6FF),
    background: Color(0xFF0D1117),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF161B22),
    elevation: 0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  cardColor: const Color(0xFF161B22),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1F6FEB),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF1F6FEB),
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white70),
    bodyLarge: TextStyle(color: Colors.white),
  ),
);
