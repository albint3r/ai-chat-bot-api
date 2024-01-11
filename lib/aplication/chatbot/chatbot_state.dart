part of 'chatbot_bloc.dart';

@freezed
class ChatBotState with _$ChatBotState {
  const factory ChatBotState({
    required bool isLoading,
    required List<IChatConversation> chatConversation,
    required List<IChatConversation> suggestedQuestions,
    FormGroup? formGroup,
  }) = _ChatBotState;

  factory ChatBotState.initial() => const ChatBotState(
        isLoading: true,
        chatConversation: [],
        suggestedQuestions: [],
      );
}
