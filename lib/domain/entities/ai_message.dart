import 'package:equatable/equatable.dart';

class AiMessage extends Equatable {
  final String message;
  final bool isUser;

  const AiMessage({
    required this.message,
    required this.isUser,
  });

  @override
  List<Object?> get props => [
        message,
        isUser,
      ];
}