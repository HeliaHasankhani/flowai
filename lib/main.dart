import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme/app_theme.dart';
import 'presentation/bloc/task/task_bloc.dart';
import 'presentation/bloc/task/task_event.dart';
import 'presentation/screens/home/home_screen.dart';

void main() {
  runApp(const FlowAIApp());
}

class FlowAIApp extends StatelessWidget {
  const FlowAIApp({super.key});

  @override
 Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => TaskBloc()..add(const LoadTasks()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowAI',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    ),
  );
}
}