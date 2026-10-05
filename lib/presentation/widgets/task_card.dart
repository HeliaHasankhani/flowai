import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool isCompleted;

  final VoidCallback? onToggle;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
    this.onToggle,
    this.onDelete,
    this.onEdit,
  });

  void _showTaskActions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (sheetContext) {
        final theme = Theme.of(context);

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ------------------------------------------------
                // TITLE
                // ------------------------------------------------

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ------------------------------------------------
                // EDIT
                // ------------------------------------------------

                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  title: const Text(
                    'Edit task',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Change task details',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    onEdit?.call();
                  },
                ),

                const SizedBox(height: 6),

                // ------------------------------------------------
                // DELETE
                // ------------------------------------------------

                ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 4,
                  ),
                  leading: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: theme.colorScheme.onErrorContainer,
                    ),
                  ),
                  title: Text(
                    'Delete task',
                    style: TextStyle(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: const Text(
                    'Remove this task',
                  ),
                  onTap: () {
                    Navigator.pop(sheetContext);
                    _showDeleteConfirmation(context);
                  },
                ),

                const SizedBox(height: 10),

                // ------------------------------------------------
                // CANCEL
                // ------------------------------------------------

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(sheetContext);
                    },
                    child: const Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
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
                Navigator.pop(dialogContext);
                onDelete?.call();
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final titleColor = isCompleted
        ? theme.colorScheme.onSurfaceVariant
        : theme.colorScheme.onSurface;

    final cardColor = isCompleted
        ? theme.colorScheme.surfaceContainerLow
        : theme.colorScheme.surface;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCompleted
              ? theme.colorScheme.outlineVariant.withValues(
                  alpha: 0.6,
                )
              : theme.colorScheme.outlineVariant,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ======================================================
          // CHECK BUTTON
          // ======================================================

          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onToggle,
              borderRadius: BorderRadius.circular(30),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 220),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (
                    Widget child,
                    Animation<double> animation,
                  ) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                  child: Container(
                    key: ValueKey(isCompleted),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? theme.colorScheme.primary
                          : Colors.transparent,
                    ),
                    child: Icon(
                      isCompleted
                          ? Icons.check_rounded
                          : Icons.circle_outlined,
                      size: isCompleted ? 20 : 28,
                      color: isCompleted
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 14),

          // ======================================================
          // TASK CONTENT
          // ======================================================

          Expanded(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: theme.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration: isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationThickness: 1.5,
                    ),
                  ),

                  const SizedBox(height: 7),

                  // TIME
                  Row(
                    children: [
                      Icon(
                        Icons.schedule_rounded,
                        size: 15,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 4),

          // ======================================================
          // MORE BUTTON
          // ======================================================

          IconButton(
            tooltip: 'Task options',
            onPressed: () {
              _showTaskActions(context);
            },
            icon: Icon(
              Icons.more_horiz_rounded,
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}