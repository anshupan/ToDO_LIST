import 'package:flutter/material.dart';
import 'package:learn1/add_task_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> tasks = [];

  void addTask(String task, String date, String time) {
    setState(() {
      tasks.add({"task": task, "date": date, "time": time});
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("To-Do List"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            tasks.isEmpty
                ? const Center(
                  child: Text(
                    "No tasks added yet!",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                )
                : ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        title: Text(
                          tasks[index]["task"]!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        subtitle: Text(
                          "📅 ${tasks[index]["date"]}   🕒 ${tasks[index]["time"]}",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => removeTask(index),
                        ),
                      ),
                    );
                  },
                ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskPage()),
          );
          if (result != null) {
            addTask(result["task"], result["date"], result["time"]);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
