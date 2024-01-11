import 'package:reactive_forms/reactive_forms.dart';
import 'i_chat_conversation.dart';

abstract interface class IChatBotFacade {
  FormGroup? get formGroup;

  List<IChatConversation> getRandomNSuggestedQuestion({
    int n = 4,
  });

  List<IChatConversation> addQuestionToConversation({String? textQuestion});

  Future<List<IChatConversation>> postQuestion({
    String? textQuestion,
  });
}
