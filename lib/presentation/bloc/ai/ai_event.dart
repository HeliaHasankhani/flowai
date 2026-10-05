import 'package:equatable/equatable.dart';

abstract class AiEvent extends Equatable {
  const AiEvent();

  @override
  List<Object?> get props => [];
}

class SendMessage extends AiEvent {
  final String message;

  const SendMessage(this.message);

  @override
  List<Object?> get props => [message];
}