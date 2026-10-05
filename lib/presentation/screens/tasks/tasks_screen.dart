import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/task/task_bloc.dart';
import '../../bloc/task/task_event.dart';
import '../../bloc/task/task_state.dart';
import '../../widgets/task_card.dart';

enum TaskFilter { all, pending, completed }

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  TaskFilter _selectedFilter = TaskFilter.all;

  List<dynamic> _filteredTasks(TaskState state) {
    switch (_selectedFilter) {
      case TaskFilter.all:
        return state.tasks;

      case TaskFilter.pending:
        return state.tasks.where((task) => !task.isCompleted).toList();

      case TaskFilter.completed:
        return state.tasks.where((task) => task.isCompleted).toList();
    }
  }

  String _filterTitle() {
    switch (_selectedFilter) {
      case TaskFilter.all:
        return 'All Tasks';

      case TaskFilter.pending:
        return 'Pending Tasks';

      case TaskFilter.completed:
        return 'Completed Tasks';
    }
  }

  void _showAddTaskSheet(BuildContext context) {
    final titleController = TextEditingController();
    final timeController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              MediaQuery.of(sheetContext).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create new task',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'Add something you want to accomplish.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    hintText: 'e.g. Learn Flutter BLoC',
                    prefixIcon: const Icon(Icons.task_alt_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: timeController,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    hintText: 'e.g. 10:00',
                    prefixIcon: const Icon(Icons.schedule_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () {
                      final title = titleController.text.trim();
                      final time = timeController.text.trim();

                      if (title.isEmpty) {
                        return;
                      }

                      context.read<TaskBloc>().add(
                            AddTask(
                              title: title,
                              time: time.isEmpty ? 'Any time' : time,
                            ),
                          );

                      Navigator.pop(sheetContext);
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text(
                      'Create Task',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditTaskSheet(
    BuildContext context,
    int index,
    String currentTitle,
    String currentTime,
  ) {
    final titleController = TextEditingController(text: currentTitle);
    final timeController = TextEditingController(text: currentTime);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              8,
              20,
              MediaQuery.of(sheetContext).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit task',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Text(
                  'Update your task details.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    prefixIcon: const Icon(Icons.edit_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: timeController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    prefixIcon: const Icon(Icons.schedule_rounded),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton.icon(
                    onPressed: () {
                      final title = titleController.text.trim();
                      final time = timeController.text.trim();

                      if (title.isEmpty) {
                        return;
                      }

                      context.read<TaskBloc>().add(
                            UpdateTask(
                              index: index,
                              title: title,
                              time: time.isEmpty ? 'Any time' : time,
                            ),
                          );

                      Navigator.pop(sheetContext);
                    },
                    icon: const Icon(Icons.save_rounded),
                    label: const Text(
                      'Save Changes',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int index,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete task?'),
          content: Text('"$title" will be permanently deleted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () {
                context.read<TaskBloc>().add(DeleteTask(index));
                Navigator.pop(dialogContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    String title,
    TaskFilter filter,
  ) {
    final theme = Theme.of(context);
    final isSelected = _selectedFilter == filter;

    return ChoiceChip(
      label: Text(title),
      selected: isSelected,
      onSelected: (_) {
        setState(() {
          _selectedFilter = filter;
        });
      },
      selectedColor: theme.colorScheme.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected
            ? theme.colorScheme.onPrimaryContainer
            : theme.colorScheme.onSurfaceVariant,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.outlineVariant,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    String title;
    String description;
    IconData icon;

    switch (_selectedFilter) {
      case TaskFilter.all:
        icon = Icons.task_alt_rounded;
        title = 'No tasks yet';
        description =
            'Create your first task and start being productive.';
        break;

      case TaskFilter.pending:
        icon = Icons.check_circle_outline_rounded;
        title = 'No pending tasks';
        description =
            'Great! You have completed all your tasks.';
        break;

      case TaskFilter.completed:
        icon = Icons.emoji_events_outlined;
        title = 'No completed tasks';
        description =
            'Complete a task and it will appear here.';
        break;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 42,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Tasks',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet(context);
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          final tasks = _filteredTasks(state);

          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                child: Row(
                  children: [
                    _buildFilterButton(
                      context,
                      'All',
                      TaskFilter.all,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      context,
                      'Pending',
                      TaskFilter.pending,
                    ),
                    const SizedBox(width: 8),
                    _buildFilterButton(
                      context,
                      'Completed',
                      TaskFilter.completed,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      _filterTitle(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${tasks.length}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: tasks.isEmpty
                    ? _buildEmptyState(context)
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(
                          20,
                          0,
                          20,
                          120,
                        ),
                        itemCount: tasks.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final task = tasks[index];

                          final originalIndex =
                              state.tasks.indexOf(task);

                          return TaskCard(
                            title: task.title,

                            // FIX:
                            // task.time is nullable.
                            subtitle: task.time ?? 'Any time',

                            isCompleted: task.isCompleted,

                            onToggle: () {
                              context.read<TaskBloc>().add(
                                    ToggleTask(originalIndex),
                                  );
                            },

                            onDelete: () {
                              _showDeleteConfirmation(
                                context,
                                originalIndex,
                                task.title,
                              );
                            },

                            onEdit: () {
                              _showEditTaskSheet(
                                context,
                                originalIndex,
                                task.title,
                                // FIX:
                                // Never pass null to String.
                                task.time ?? 'Any time',
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
