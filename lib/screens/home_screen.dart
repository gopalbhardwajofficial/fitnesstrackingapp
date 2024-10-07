import 'package:flutter/material.dart';
import 'workout_screen.dart';
import 'goal_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of screens corresponding to the BottomNavigationBar items
  final List<Widget> _screens = [
    AddWorkoutScreen(),
    SetGoalScreen(),
    ProgressScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness Tracker'),
        backgroundColor: Colors.black54,
        elevation: 0,
      ),
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.black54,
        selectedItemColor: Colors.tealAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'Add Workout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'Set Goal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
        ],
      ),
    );
  }
}
