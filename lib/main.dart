import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(FitnessTrackerApp());
}

class FitnessTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Updated for newer Flutter versions
          bodyMedium: TextStyle(color: Colors.white70), // Updated for newer Flutter versions
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(),
    );
  }
}
