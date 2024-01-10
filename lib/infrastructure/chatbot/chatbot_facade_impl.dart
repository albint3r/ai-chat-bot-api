import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';

import '../../domain/chatbot/i_chatbot_facade.dart';

@Injectable(as: IChatBotFacade)
class ChatBotFacadeImpl implements IChatBotFacade {
  final _formGroup = FormGroup({'question': FormControl<String>(value: '')});

  @override
  FormGroup? get formGroup => _formGroup;

  @override
  Future<void> postQuestion() async {
    final control = _formGroup.control('question');
    final question = control.value as String;
    print('question-> $question');
    control.value = '';
  }
}
