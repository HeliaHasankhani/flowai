import 'package:equatable/equatable.dart';

import '../../../domain/entities/ai_message.dart';

class AiState extends Equatable {
  final List<AiMessage> messages;
  final bool isLoading;

  const AiState({
    this.messages = const [],
    this.isLoading = false,
  });

  AiState copyWith({
    List<AiMessage>? messages,
    bool? isLoading,
  }) {
    return AiState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        messages,
        isLoading,
      ];
}