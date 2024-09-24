import 'package:flutter/material.dart';

void main() {
  runApp(ReminderApp());
}

class ReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Reminder App',
      home: ReminderHomePage(),
    );
  }
}

class ReminderHomePage extends StatefulWidget {
  @override
  _ReminderHomePageState createState() => _ReminderHomePageState();
}

class _ReminderHomePageState extends State<ReminderHomePage> {
  String selectedDay = "Monday"; // Default value
  TimeOfDay selectedTime = TimeOfDay.now(); // Default to current time
  String selectedActivity = "Wake up"; // Default value

  final List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  final List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  // Function to handle Time Picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Reminder'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for Day
            DropdownButton<String>(
              value: selectedDay,
              items: daysOfWeek.map((String day) {
                return DropdownMenuItem<String>(
                  value: day,
                  child: Text(day),
                );
              }).toList(),
              onChanged: (String? newDay) {
                setState(() {
                  selectedDay = newDay!;
                });
              },
            ),

            // Time Picker Button
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text("Choose Time: ${selectedTime.format(context)}"),
            ),

            // Dropdown for Activity
            DropdownButton<String>(
              value: selectedActivity,
              items: activities.map((String activity) {
                return DropdownMenuItem<String>(
                  value: activity,
                  child: Text(activity),
                );
              }).toList(),
              onChanged: (String? newActivity) {
                setState(() {
                  selectedActivity = newActivity!;
                });
              },
            ),

            // Submit button or set reminder button (for future functionality)
            ElevatedButton(
              onPressed: () {
                // Logic to set the reminder, will be implemented later
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Reminder set for $selectedDay at ${selectedTime.format(context)} for $selectedActivity."),
                ));
              },
              child: Text('Set Reminder'),
            ),
          ],
        ),
      ),
    );
  }
}
