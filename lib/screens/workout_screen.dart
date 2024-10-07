import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWorkoutScreen extends StatefulWidget {
  @override
  _AddWorkoutScreenState createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  String? _selectedWorkoutType;
  List<String> _workoutTypes = ['Running', 'Cycling', 'Yoga', 'Strength Training']; // Predefined workout types
  List<String> _workouts = [];

  @override
  void initState() {
    super.initState();
    _loadWorkouts();
  }

  // Load workouts from SharedPreferences
  Future<void> _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _workouts = prefs.getStringList('workouts') ?? [];
    });
  }

  // Save workouts to SharedPreferences
  Future<void> _saveWorkout() async {
    if (_selectedWorkoutType != null && _durationController.text.isNotEmpty && _caloriesController.text.isNotEmpty) {
      String workout = "${_selectedWorkoutType} | Duration: ${_durationController.text} mins | Calories: ${_caloriesController.text}";
      _workouts.add(workout);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('workouts', _workouts);

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Workout Added Successfully!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Workout Type',
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
              ),
              value: _selectedWorkoutType,
              items: _workoutTypes.map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedWorkoutType = value;
                });
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Duration (minutes)',
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Calories Burned',
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                onPressed: _saveWorkout,
                child: Text('Add Workout'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _workouts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_workouts[index]),
                    leading: Icon(Icons.fitness_center, color: Colors.tealAccent),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
