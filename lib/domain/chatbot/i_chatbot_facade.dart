import 'package:reactive_forms/reactive_forms.dart';

import 'answer.dart';

abstract interface class IChatBotFacade {
  FormGroup? get formGroup;

  Future<List<Answer>> postQuestion();
}
