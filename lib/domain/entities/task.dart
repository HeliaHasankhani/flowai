
import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String title;
  final String? time;
  final bool isCompleted;

  const Task({
    required this.title,
    this.time,
    required this.isCompleted,
  });

  Task copyWith({
    String? title,
    String? time,
    bool? isCompleted,
  }) {
    return Task(
      title: title ?? this.title,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [
        title,
        time,
        isCompleted,
      ];
}
