import '../../core/network/api_service.dart';
import '../../domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final ApiService apiService;

  AiRepositoryImpl({
    required this.apiService,
  });

  @override
  Future<String> sendMessage(String message) {
    return apiService.sendMessage(message);
  }
}