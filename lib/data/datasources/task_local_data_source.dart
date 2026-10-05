import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/task.dart';

class TaskLocalDataSource {
  static const String _tasksKey = 'flowai_tasks';

  Future<List<Task>> getTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final tasksJson = prefs.getString(_tasksKey);

    if (tasksJson == null) {
      return [];
    }

    final List<dynamic> decoded = jsonDecode(tasksJson);

    return decoded.map((item) {
      return Task(
        title: item['title'] as String,
        time: item['time'] as String?,
        isCompleted: item['isCompleted'] as bool,
      );
    }).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();

    final tasksJson = jsonEncode(
      tasks.map((task) {
        return {
          'title': task.title,
          'time': task.time,
          'isCompleted': task.isCompleted,
        };
      }).toList(),
    );

    await prefs.setString(_tasksKey, tasksJson);
  }

  Future<void> clearTasks() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tasksKey);
  }
}
