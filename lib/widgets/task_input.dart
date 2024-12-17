// lib/widgets/task_input.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class TaskInput extends StatefulWidget {
  const TaskInput({super.key});

  @override
  _TaskInputState createState() => _TaskInputState();
}

class _TaskInputState extends State<TaskInput> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Task Input Field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _taskController,
                decoration: const InputDecoration(
                  hintText: 'Enter a new task',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),
          ),
          
          // Add Task Button
          const SizedBox(width: 8),
          GestureDetector(
            onTap: _addTask,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Method to add a task
  void _addTask() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    
    if (_taskController.text.trim().isNotEmpty) {
      taskProvider.addTask(_taskController.text.trim());
      _taskController.clear();
    } else {
      // Show a snackbar if task is empty
      ScaffoldMessenger.of(context).showMaterialBanner(
        MaterialBanner(
          content: const Text('Task cannot be empty!'),
          actions: [
            TextButton(
              child: const Text('DISMISS'),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
            ),
          ],
          backgroundColor: Colors.red.shade100,
        ),
      );
      
      // Hide the banner after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      });
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}