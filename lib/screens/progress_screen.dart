import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  List<double> _caloriesData = [];
  double _targetCalories = 0.0;
  int _days = 0;

  @override
  void initState() {
    super.initState();
    _loadWorkoutData();
  }

  // Load workout and goal data from SharedPreferences
  Future<void> _loadWorkoutData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? workouts = prefs.getStringList('workouts');
    List<String>? goals = prefs.getStringList('goals');

    // Parse workout data
    if (workouts != null) {
      _caloriesData = workouts.map((workout) {
        final parts = workout.split('|');
        final caloriesStr = parts[2].replaceAll(RegExp(r'Calories: '), '');
        return double.tryParse(caloriesStr) ?? 0.0;
      }).toList();
    }

    // Parse goal data (take the latest goal)
    if (goals != null && goals.isNotEmpty) {
      final lastGoal = goals.last;
      final targetCaloriesStr = lastGoal.split(',')[0].replaceAll(RegExp(r'Target Calories: '), '');
      final daysStr = lastGoal.split(',')[1].replaceAll(RegExp(r'Days: '), '');

      _targetCalories = double.tryParse(targetCaloriesStr) ?? 0.0;
      _days = int.tryParse(daysStr) ?? 0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Workout Progress',
              style: TextStyle(fontSize: 24, color: Colors.tealAccent),
            ),
            SizedBox(height: 20),
            _targetCalories > 0
                ? Text(
              'Goal: $_targetCalories calories in $_days days',
              style: TextStyle(color: Colors.tealAccent, fontSize: 16),
            )
                : Container(),
            SizedBox(height: 20),
            Expanded(
              child: _caloriesData.isEmpty
                  ? Center(
                child: Text('No Data Available', style: TextStyle(color: Colors.white70)),
              )
                  : LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: _caloriesData
                          .asMap()
                          .entries
                          .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
                          .toList(),
                      isCurved: true,
                color: Colors.tealAccent,
                barWidth: 4,
                belowBarData: BarAreaData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
