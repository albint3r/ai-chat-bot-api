import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../domain/chatbot/answer.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';

part 'chatbot_bloc.freezed.dart';

part 'chatbot_event.dart';

part 'chatbot_state.dart';

@injectable
class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc(IChatBotFacade facade) : super(ChatBotState.initial()) {
    on<_Started>((event, emit) {
      emit(
        state.copyWith(
          formGroup: facade.formGroup,
          isLoading: false,
        ),
      );
    });
    on<_PostQuestion>((event, emit) async {
      final answers = await facade.postQuestion();
      print("1 before anser->$answers");
      if (answers.isNotEmpty) {
        print("2 after anser->$answers");
        emit(
          state.copyWith(
            answers: List.from(answers),
          ),
        );
        print("3 STATE->${state.answers}");
      }
    });
  }
}
