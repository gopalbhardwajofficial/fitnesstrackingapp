import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetGoalScreen extends StatefulWidget {
  @override
  _SetGoalScreenState createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final TextEditingController _caloriesController = TextEditingController(); // Target calories
  final TextEditingController _daysController = TextEditingController(); // Number of days
  List<String> _goals = [];

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  // Load goals from SharedPreferences
  Future<void> _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _goals = prefs.getStringList('goals') ?? [];
    });
  }

  // Save goals to SharedPreferences
  Future<void> _saveGoal() async {
    if (_caloriesController.text.isNotEmpty && _daysController.text.isNotEmpty) {
      String goal = "Target Calories: ${_caloriesController.text}, Days: ${_daysController.text}";
      _goals.add(goal);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('goals', _goals);

      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Goal Set Successfully!')));
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
            TextField(
              controller: _caloriesController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Target Calories (e.g., 500)',
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _daysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of Days (e.g., 30)',
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
                onPressed: _saveGoal,
                child: Text('Set Goal'),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_goals[index]),
                    leading: Icon(Icons.flag, color: Colors.tealAccent),
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
