import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../domain/chatbot/answer_loading.dart';
import '../../domain/chatbot/i_chat_conversation.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';

part 'chatbot_bloc.freezed.dart';

part 'chatbot_event.dart';

part 'chatbot_state.dart';

@injectable
class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc(IChatBotFacade facade) : super(ChatBotState.initial()) {
    on<_Started>((event, emit) {
      final suggestedQuestions = facade.getRandomNSuggestedQuestion();
      emit(
        state.copyWith(
          formGroup: facade.formGroup,
          suggestedQuestions: suggestedQuestions,
          isLoading: false,
        ),
      );
    });
    try {
      on<_PostQuestion>((event, emit) async {
        // Add Question to logs
        final newQuestion = facade.addQuestionToConversation(
          textQuestion: event.textQuestion,
        );
        // Adding this extra line we create the effect of [loading] after the user
        // made a query. It use a [answerLoading] Entity, this entity only inform
        // the presentation to use the typing of the class to if else statement
        // and put the loading instated of the text of the user
        // [because this list is created HERE] it will be updated
        // when the API response, this will create the effect of the end
        // of the loading stage.
        final answerLoadingConversation = List<IChatConversation>.from(
          [...newQuestion, const AnswerLoading(text: '')],
        );
        emit(
          state.copyWith(
            chatConversation: answerLoadingConversation,
          ),
        );
        // Add Answer to logs
        final newAnswer = await facade.postQuestion(
          textQuestion: event.textQuestion,
        );
        if (newAnswer.isNotEmpty) {
          emit(
            state.copyWith(
              chatConversation: List.from(newAnswer),
            ),
          );
        }
      });
    } catch (e, s) {
      print(s);
    }
  }
}
