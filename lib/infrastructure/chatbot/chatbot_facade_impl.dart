import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';

import '../../domain/chatbot/i_chat_conversation.dart';
import '../../domain/chatbot/i_chatbot_data_source.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';
import '../../domain/chatbot/question.dart';
import '../../presentation/core/theme/const_values.dart';

@Injectable(as: IChatBotFacade)
class ChatBotFacadeImpl implements IChatBotFacade {
  ChatBotFacadeImpl(this._dataSource);

  final chatConversation = <IChatConversation>[];
  final IChatBotDataSource _dataSource;

  final _formGroup = FormGroup({
    'question': FormControl<String>(value: ''),
  });

  final _suggestedQuestions = allQuestion['alberto-cv']!;

  @override
  FormGroup? get formGroup => _formGroup;

  @override
  Future<List<IChatConversation>> postQuestion({
    String? textQuestion,
  }) async {
    final control = _formGroup.control('question');
    textQuestion = textQuestion ?? control.value as String;
    control.value = '';
    if (textQuestion.isNotEmpty) {
      final answer = await _dataSource.postQuestionQA(textQuestion);
      chatConversation.add(answer);
      return chatConversation;
    }
    return [];
  }

  @override
  List<IChatConversation> addQuestionToConversation({
    String? textQuestion,
  }) {
    final control = _formGroup.control('question');
    textQuestion = textQuestion ?? control.value as String;
    final question = Question(text: textQuestion);
    chatConversation.add(question);
    return chatConversation;
  }

  @override
  List<IChatConversation> getRandomNSuggestedQuestion({int n = 4}) {
    final rng = Random();
    final Set suggestedQuestions = {};
    while (suggestedQuestions.length < n) {
      final randIndex = rng.nextInt(_suggestedQuestions.length);
      suggestedQuestions.add(_suggestedQuestions[randIndex]);
    }
    return List.from(suggestedQuestions);
  }
}
