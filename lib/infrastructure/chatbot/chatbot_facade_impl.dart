import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';

import '../../domain/chatbot/answer.dart';
import '../../domain/chatbot/i_chatbot_data_source.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';

@Injectable(as: IChatBotFacade)
class ChatBotFacadeImpl implements IChatBotFacade {
  ChatBotFacadeImpl(this._dataSource);

  final answers = <Answer>[];
  final IChatBotDataSource _dataSource;

  final _formGroup = FormGroup({
    'question': FormControl<String>(value: ''),
  });

  @override
  FormGroup? get formGroup => _formGroup;

  @override
  Future<List<Answer>> postQuestion() async {
    final control = _formGroup.control('question');
    final question = control.value as String;
    control.value = '';
    if (question.isNotEmpty) {
      final answer = await _dataSource.postQuestionQA(question);
      // reset the field value.
      answers.add(answer);
      return answers;
    }
    return [];
  }
}
