import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';

class QuestionTextField extends StatelessWidget {
  const QuestionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<ChatBotBloc>().state;
    return SizedBox(
      width: 700,
      child: ReactiveForm(
        formGroup: form.formGroup!,
        child: ReactiveTextField(
          formControlName: 'question',
        ),
      ),
    );
  }
}
