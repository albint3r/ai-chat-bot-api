import 'package:reactive_forms/reactive_forms.dart';

abstract interface class IChatBotFacade {
  FormGroup? get formGroup;

  Future<void> postQuestion();
}
