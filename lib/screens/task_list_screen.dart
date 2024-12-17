// lib/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import '../widgets/task_input.dart';
import '../widgets/task_list.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              // Show app info
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Task Manager App - Manage your daily tasks!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: const Column(
        children: [
          // Task Input Widget
          TaskInput(),
          
          // Task List Widget
          Expanded(child: TaskList()),
        ],
      ),
    );
  }
}