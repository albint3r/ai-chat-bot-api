import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../core/theme/const_values.dart';

class QuestionTextField extends StatelessWidget {
  const QuestionTextField({super.key});

  @override
  Widget build(BuildContext context) {
    final form = context.watch<ChatBotBloc>().state;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 700,
      child: ReactiveForm(
        formGroup: form.formGroup!,
        child: ReactiveTextField(
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Transform.scale(
                scale: .8,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                  ),
                  child: IconButton(
                    hoverColor: colorScheme.primary,
                    color: colorScheme.background,
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_upward,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
          formControlName: 'question',
        ),
      ),
    );
  }
}
