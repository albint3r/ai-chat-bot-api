part of 'chatbot_bloc.dart';

@freezed
class ChatBotEvent with _$ChatBotEvent {
  const factory ChatBotEvent.started() = _Started;

  const factory ChatBotEvent.postQuestion() = _PostQuestion;
}
