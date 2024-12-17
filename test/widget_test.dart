// test/task_provider_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/models/task.dart';
import 'package:task_manager/providers/task_provider.dart';

void main() {
  group('TaskProvider Tests', () {
    late TaskProvider taskProvider;

    setUp(() {
      taskProvider = TaskProvider();
    });

    test('Add task increases task list length', () {
      final initialLength = taskProvider.tasks.length;
      taskProvider.addTask('Test Task');
      expect(taskProvider.tasks.length, equals(initialLength + 1));
    });

    test('Remove task decreases task list length', () {
      taskProvider.addTask('Test Task');
      final initialLength = taskProvider.tasks.length;
      final taskToRemove = taskProvider.tasks.last;
      taskProvider.removeTask(taskToRemove);
      expect(taskProvider.tasks.length, equals(initialLength - 1));
    });

    test('Toggle task completion changes completion status', () {
      taskProvider.addTask('Test Task');
      final task = taskProvider.tasks.last;
      final initialCompletionStatus = task.isCompleted;
      taskProvider.toggleTaskCompletion(task);
      expect(task.isCompleted, equals(!initialCompletionStatus));
    });

    test('Task model conversion works correctly', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        isCompleted: false,
      );

      final map = task.toMap();
      final recreatedTask = Task.fromMap(map);

      expect(recreatedTask.id, equals(task.id));
      expect(recreatedTask.title, equals(task.title));
      expect(recreatedTask.isCompleted, equals(task.isCompleted));
    });
  });
}