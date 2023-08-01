import 'package:firebase/services/database/write.dart';
import 'package:firebase/services/database/update.dart';
import 'package:firebase/services/database/delete.dart';
import 'package:firebase/services/database/fetch.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<HomeScreen> {
  List<String> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks(); //
  }

  void addTask(String task) async {
    setState(() {
      tasks.add(task);
    });

    String taskId = await DataWriter.create(task);
  }

  void deleteTask(int index) async {
    setState(() {
      tasks.removeAt(index);
    });

    String taskId = "";
    if (taskId.isNotEmpty) {
      await DataDeleter.delete(taskId);
    } else {
      debugPrint('Error: Task ID is empty or null');
    }
  }

  void updateTask(int index, String updatedTask) async {
    String taskId = "";
    if (taskId.isNotEmpty) {
      setState(() {
        tasks[index] = updatedTask;
      });

      await DataUpdater.update(taskId, updatedTask);
    } else {
      debugPrint('Error: Task ID is empty or null');
    }
  }

  void fetchTasks() async {
    List<Map<String, dynamic>> fetchedTasks = await DataFetcher.fetchAllTasks();
    setState(() {
      tasks = fetchedTasks.map((task) => task['task'] as String).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index]),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => deleteTask(index),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  String updatedTask = tasks[index];
                  return AlertDialog(
                    title: const Text('Update Task'),
                    content: TextField(
                      onChanged: (value) {
                        updatedTask = value;
                      },
                      controller: TextEditingController(text: tasks[index]),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (updatedTask.trim().isNotEmpty) {
                            updateTask(index, updatedTask);
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Update'),
                      ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              String newTask = "";
              return AlertDialog(
                title: const Text('Add a new task'),
                content: TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (newTask.trim().isNotEmpty) {
                        addTask(newTask);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
