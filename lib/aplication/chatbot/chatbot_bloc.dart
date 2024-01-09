import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'chatbot_event.dart';

part 'chatbot_state.dart';

part 'chatbot_bloc.freezed.dart';

@injectable
class ChatBotBloc extends Bloc<ChatBotEvent, ChatBotState> {
  ChatBotBloc() : super(ChatBotState.initial()) {
    on<_Started>((event, emit) {
      // TODO: implement event handler
    });
  }
}
