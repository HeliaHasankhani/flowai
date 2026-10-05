import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/repositories/ai_repository_impl.dart';
import '../../../domain/entities/ai_message.dart';
import '../../../domain/repositories/ai_repository.dart';
import '../../../core/network/api_service.dart';
import 'ai_event.dart';
import 'ai_state.dart';

class AiBloc extends Bloc<AiEvent, AiState> {
  final AiRepository repository;

  AiBloc({
    AiRepository? repository,
  })  : repository = repository ??
            AiRepositoryImpl(
              apiService: ApiService(
                baseUrl: 'http://localhost:3000',
              ),
            ),
        super(const AiState()) {
    on<SendMessage>(_onSendMessage);
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<AiState> emit,
  ) async {
    final userMessage = AiMessage(
      message: event.message,
      isUser: true,
    );

    emit(
      state.copyWith(
        messages: [
          ...state.messages,
          userMessage,
        ],
        isLoading: true,
      ),
    );

    try {
      final response = await repository.sendMessage(
        event.message,
      );

      final aiMessage = AiMessage(
        message: response,
        isUser: false,
      );

      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            aiMessage,
          ],
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          messages: [
            ...state.messages,
            const AiMessage(
              message:
                  'Unable to connect to the AI server.',
              isUser: false,
            ),
          ],
          isLoading: false,
        ),
      );
    }
  }
}