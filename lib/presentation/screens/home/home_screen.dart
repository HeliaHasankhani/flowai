import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flowai/presentation/screens/tasks/tasks_screen.dart';

import '../../../domain/entities/task.dart';
import '../../bloc/task/task_bloc.dart';
import '../../bloc/task/task_event.dart';
import '../../bloc/task/task_state.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/task_card.dart';
import '../ai_assistant/ai_assistant_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // ------------------------------------------------------------
  // GREETING
  // ------------------------------------------------------------

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning 👋';
    }

    if (hour < 17) {
      return 'Good afternoon 👋';
    }

    return 'Good evening 👋';
  }

  // ------------------------------------------------------------
  // ADD TASK
  // ------------------------------------------------------------

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
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Add something you want to accomplish.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                ),

                const SizedBox(height: 24),

                // TITLE
                TextField(
                  controller: titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    hintText: 'e.g. Learn Flutter BLoC',
                    prefixIcon: const Icon(
                      Icons.task_alt_rounded,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                // TIME
                TextField(
                  controller: timeController,
                  keyboardType: TextInputType.datetime,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Time',
                    hintText: 'e.g. 10:00',
                    prefixIcon: const Icon(
                      Icons.schedule_rounded,
                    ),
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
                              time: time.isEmpty
                                  ? 'Any time'
                                  : time,
                            ),
                          );

                      Navigator.pop(sheetContext);
                    },
                    icon: const Icon(Icons.add_rounded),
                    label: const Text(
                      'Create Task',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
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

  // ------------------------------------------------------------
  // EDIT TASK
  // ------------------------------------------------------------

  void _showEditTaskSheet(
    BuildContext context,
    int index,
    Task task,
  ) {
    final titleController = TextEditingController(
      text: task.title,
    );

    final timeController = TextEditingController(
      text: task.time,
    );

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
                      ?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Update your task details.',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurfaceVariant,
                      ),
                ),

                const SizedBox(height: 24),

                TextField(
                  controller: titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Task title',
                    prefixIcon: const Icon(
                      Icons.edit_rounded,
                    ),
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
                    prefixIcon: const Icon(
                      Icons.schedule_rounded,
                    ),
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
                              time: time.isEmpty
                                  ? 'Any time'
                                  : time,
                            ),
                          );

                      Navigator.pop(sheetContext);
                    },
                    icon: const Icon(
                      Icons.save_rounded,
                    ),
                    label: const Text(
                      'Save Changes',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
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

  // ------------------------------------------------------------
  // DELETE CONFIRMATION
  // ------------------------------------------------------------

  void _showDeleteConfirmation(
    BuildContext context,
    int index,
    String title,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        final theme = Theme.of(context);

        return AlertDialog(
          title: const Text('Delete task?'),
          content: Text(
            '"$title" will be permanently deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.error,
                foregroundColor: theme.colorScheme.onError,
              ),
              onPressed: () {
                context.read<TaskBloc>().add(
                      DeleteTask(index),
                    );

                Navigator.pop(dialogContext);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,

      // ----------------------------------------------------------
      // APP BAR
      // ----------------------------------------------------------

      appBar: AppBar(
        title: const Text(
          'FlowAI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'AI Assistant',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AiAssistantScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.auto_awesome_rounded,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      // ----------------------------------------------------------
      // BODY
      // ----------------------------------------------------------

      body: SafeArea(
        child: BlocBuilder<TaskBloc, TaskState>(
          builder: (context, state) {
            final totalTasks = state.tasks.length;

            final completedTasks = state.tasks
                .where((task) => task.isCompleted)
                .length;

            final pendingTasks =
                totalTasks - completedTasks;

            final progress = totalTasks == 0
                ? 0.0
                : completedTasks / totalTasks;

            // Show only first 3 tasks on dashboard.
            final visibleTasks = state.tasks.take(3).toList();

            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                20,
                12,
                20,
                110,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ==================================================
                  // GREETING
                  // ==================================================

                  Text(
                    _getGreeting(),
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    'Let’s make today productive.',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ==================================================
                  // DAILY PROGRESS
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Expanded(
                              child: Text(
                                'Daily Progress',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              '${(progress * 100).round()}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            backgroundColor:
                                Colors.white.withValues(
                              alpha: 0.25,
                            ),
                            color: Colors.orange,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          totalTasks == 0
                              ? 'Add your first task to get started.'
                              : completedTasks == totalTasks
                                  ? 'All tasks completed! 🎉'
                                  : '$completedTasks of '
                                      '$totalTasks tasks completed',
                          style: const TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // STATISTICS
                  // ==================================================

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          icon: Icons.task_alt_rounded,
                          value: '$completedTasks',
                          label: 'Completed',
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: StatCard(
                          icon: Icons.pending_actions_rounded,
                          value: '$pendingTasks',
                          label: 'Pending',
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // TASK HEADER
                  // ==================================================

                  Row(
                    children: [
                      Text(
                        'Today’s Tasks',
                        style:
                            theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const Spacer(),

                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  const TasksScreen(),
                            ),
                          );
                        },
                        child: const Text('See all'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // ==================================================
                  // EMPTY STATE
                  // ==================================================

                  if (state.tasks.isEmpty)
                    _buildEmptyTasks(context)

                  // ==================================================
                  // TASK LIST
                  // ==================================================

                  else
                    Column(
                      children: [
                        ...visibleTasks.asMap().entries.map(
                          (entry) {
                            final visibleIndex = entry.key;
                            final task = entry.value;

                            final originalIndex =
                                state.tasks.indexOf(task);

                            return Padding(
                              padding:
                                  const EdgeInsets.only(
                                bottom: 12,
                              ),
                              child: TaskCard(
                                title: task.title,
                                subtitle: task.time ?? 'Any time',
                                isCompleted:
                                    task.isCompleted,

                                // TOGGLE
                                onToggle: () {
                                  context
                                      .read<TaskBloc>()
                                      .add(
                                        ToggleTask(
                                          originalIndex,
                                        ),
                                      );
                                },

                                // EDIT
                                onEdit: () {
                                  _showEditTaskSheet(
                                    context,
                                    originalIndex,
                                    task,
                                  );
                                },

                                // DELETE
                                onDelete: () {
                                  _showDeleteConfirmation(
                                    context,
                                    originalIndex,
                                    task.title,
                                  );
                                },
                              ),
                            );
                          },
                        ),

                        // Show "See all" if there are more than 3.
                        if (state.tasks.length > 3)
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4),
                            child: SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const TasksScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'View all ${state.tasks.length} tasks',
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),

                  const SizedBox(height: 28),

                  // ==================================================
                  // AI ASSISTANT
                  // ==================================================

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color:
                            theme.colorScheme.outlineVariant,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary
                                .withValues(alpha: 0.1),
                            borderRadius:
                                BorderRadius.circular(16),
                          ),
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            color:
                                theme.colorScheme.primary,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AI Assistant',
                                style: theme
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                'Need help planning your day? '
                                'Let AI organize your tasks.',
                                style: theme
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                  color: theme
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                              ),

                              const SizedBox(height: 12),

                              FilledButton.tonal(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          const AiAssistantScreen(),
                                    ),
                                  );
                                },
                                child:
                                    const Text('Ask AI'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // ------------------------------------------------------------
      // FAB
      // ------------------------------------------------------------

      floatingActionButton:
          FloatingActionButton(
        onPressed: () {
          _showAddTaskSheet(context);
        },
        child: const Icon(
          Icons.add_rounded,
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // EMPTY TASKS
  // ------------------------------------------------------------

  Widget _buildEmptyTasks(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.checklist_rounded,
            size: 44,
            color: theme.colorScheme.onSurfaceVariant,
          ),

          const SizedBox(height: 12),

          Text(
            'No tasks yet',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            'Add your first task for today.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),

          const SizedBox(height: 16),

          FilledButton.icon(
            onPressed: () {
              _showAddTaskSheet(context);
            },
            icon: const Icon(
              Icons.add_rounded,
            ),
            label: const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}