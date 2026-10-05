import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/task_local_data_source.dart';
import '../../../domain/entities/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskLocalDataSource localDataSource;

  TaskBloc({
    TaskLocalDataSource? localDataSource,
  })  : localDataSource = localDataSource ?? TaskLocalDataSource(),
        super(const TaskState()) {
    on<LoadTasks>(_onLoadTasks);
    on<AddTask>(_onAddTask);
    on<ToggleTask>(_onToggleTask);
    on<DeleteTask>(_onDeleteTask);
    on<UpdateTask>(_onUpdateTask);
  }

  // Load tasks from local storage
  Future<void> _onLoadTasks(
    LoadTasks event,
    Emitter<TaskState> emit,
  ) async {
    final tasks = await localDataSource.getTasks();

    // First launch: create default tasks
    if (tasks.isEmpty) {
      final defaultTasks = [
        const Task(
          title: 'Learn Flutter BLoC',
          time: '10:00',
          isCompleted: false,
        ),
        const Task(
          title: 'Practice English',
          time: '12:00',
          isCompleted: true,
        ),
        const Task(
          title: 'Work on FlowAI',
          time: '15:00',
          isCompleted: false,
        ),
      ];

      await localDataSource.saveTasks(defaultTasks);

      emit(
        TaskState(
          tasks: defaultTasks,
        ),
      );

      return;
    }

    emit(
      TaskState(
        tasks: tasks,
      ),
    );
  }

  // Add task
  Future<void> _onAddTask(
    AddTask event,
    Emitter<TaskState> emit,
  ) async {
    final updatedTasks = [
      ...state.tasks,
      Task(
        title: event.title,
        time: event.time,
        isCompleted: false,
      ),
    ];

    await localDataSource.saveTasks(updatedTasks);

    emit(
      TaskState(
        tasks: updatedTasks,
      ),
    );
  }

  // Toggle task
  Future<void> _onToggleTask(
    ToggleTask event,
    Emitter<TaskState> emit,
  ) async {
    if (event.index < 0 || event.index >= state.tasks.length) {
      return;
    }

    final updatedTasks = List<Task>.from(state.tasks);

    final task = updatedTasks[event.index];

    updatedTasks[event.index] = Task(
      title: task.title,
      time: task.time,
      isCompleted: !task.isCompleted,
    );

    await localDataSource.saveTasks(updatedTasks);

    emit(
      TaskState(
        tasks: updatedTasks,
      ),
    );
  }

  // Delete task
  Future<void> _onDeleteTask(
    DeleteTask event,
    Emitter<TaskState> emit,
  ) async {
    if (event.index < 0 || event.index >= state.tasks.length) {
      return;
    }

    final updatedTasks = List<Task>.from(state.tasks);

    updatedTasks.removeAt(event.index);

    await localDataSource.saveTasks(updatedTasks);

    emit(
      TaskState(
        tasks: updatedTasks,
      ),
    );
  }

  // Update task
  Future<void> _onUpdateTask(
    UpdateTask event,
    Emitter<TaskState> emit,
  ) async {
    if (event.index < 0 || event.index >= state.tasks.length) {
      return;
    }}}