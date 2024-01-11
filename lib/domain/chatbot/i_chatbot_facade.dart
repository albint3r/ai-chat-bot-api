import 'package:reactive_forms/reactive_forms.dart';

import 'answer.dart';
import 'i_chat_conversation.dart';

abstract interface class IChatBotFacade {
  FormGroup? get formGroup;

  List<IChatConversation> addQuestionToConversation();

  Future<List<IChatConversation>> postQuestion();
}
