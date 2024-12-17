// lib/providers/task_provider.dart
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  late SharedPreferences _prefs;

  List<Task> get tasks => _tasks;

  TaskProvider() {
    _initSharedPreferences();
  }

  // Initialize SharedPreferences and load tasks
  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    _loadTasks();
  }

  // Load tasks from SharedPreferences
  void _loadTasks() {
    List<String>? taskStrings = _prefs.getStringList('tasks');
    if (taskStrings != null) {
      _tasks = taskStrings
          .map((taskString) => Task.fromMap(parseTaskString(taskString)))
          .toList();
      notifyListeners();
    }
  }

  // Save tasks to SharedPreferences
  void _saveTasks() {
    List<String> taskStrings = _tasks.map((task) => task.toMap().toString()).toList();
    _prefs.setStringList('tasks', taskStrings);
  }

  // Add a new task
  void addTask(String title) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
    );
    _tasks.add(newTask);
    _saveTasks();
    notifyListeners();
  }

  // Remove a task
  void removeTask(Task task) {
    _tasks.remove(task);
    _saveTasks();
    notifyListeners();
  }

  // Toggle task completion status
  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    _saveTasks();
    notifyListeners();
  }

  // Helper method to parse task string to Map
  Map<String, dynamic> parseTaskString(String taskString) {
    // Remove the surrounding braces and split the string
    String cleanedString = taskString.replaceAll('{', '').replaceAll('}', '');
    Map<String, dynamic> taskMap = {};
    
    cleanedString.split(', ').forEach((pair) {
      List<String> keyValue = pair.split(': ');
      if (keyValue.length == 2) {
        String key = keyValue[0].trim();
        String value = keyValue[1].trim();
        
        // Convert value based on key
        if (key == 'isCompleted') {
          taskMap[key] = value.toLowerCase() == 'true';
        } else {
          taskMap[key] = value.replaceAll("'", "");
        }
      }
    });
    
    return taskMap;
  }
}