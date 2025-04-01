import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  _AddTaskPageState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController _taskController = TextEditingController();
  String _selectedDate = "Select Date";
  String _selectedTime = "Select Time";

  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _pickTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime.format(context);
      });
    }
  }

  void submitTask() {
    if (_taskController.text.isNotEmpty &&
        _selectedDate != "Select Date" &&
        _selectedTime != "Select Time") {
      Navigator.pop(context, {
        "task": _taskController.text,
        "date": _selectedDate,
        "time": _selectedTime,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter a new task:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                hintText: "E.g. Buy groceries",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(_selectedDate),
              trailing: const Icon(Icons.calendar_today, color: Colors.indigo),
              onTap: () => _pickDate(context),
            ),
            ListTile(
              title: Text(_selectedTime),
              trailing: const Icon(Icons.access_time, color: Colors.indigo),
              onTap: () => _pickTime(context),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: submitTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Add Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
