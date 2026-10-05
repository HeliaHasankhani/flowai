
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class AddTask extends TaskEvent {
  final String title;
  final String? time;

  const AddTask({
    required this.title,
    this.time,
  });

  @override
  List<Object?> get props => [
        title,
        time,
      ];
}

class ToggleTask extends TaskEvent {
  final int index;

  const ToggleTask(this.index);

  @override
  List<Object?> get props => [index];
}

class DeleteTask extends TaskEvent {
  final int index;

  const DeleteTask(this.index);

  @override
  List<Object?> get props => [index];
}

class UpdateTask extends TaskEvent {
  final int index;
  final String title;
  final String? time;

  const UpdateTask({
    required this.index,
    required this.title,
    this.time,
  });

  @override
  List<Object?> get props => [
        index,
        title,
        time,
      ];
}
