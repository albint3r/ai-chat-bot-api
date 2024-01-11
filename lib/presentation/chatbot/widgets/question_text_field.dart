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
      width: textFieldWidth,
      child: ReactiveForm(
        formGroup: form.formGroup!,
        child: ReactiveTextField(
          onSubmitted: (control) => context.read<ChatBotBloc>().add(
                const ChatBotEvent.postQuestion(),
              ),
          style: theme.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Message Alberto-GPT ...',
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: padding),
              child: Transform.scale(
                scale: .8,
                child: Container(
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(borderRadius),
                    ),
                  ),
                  child: ReactiveFormConsumer(
                    builder: (_, formGroup, __) {
                      final control = formGroup.control('question');
                      final question = control.value as String;
                      return IconButton(
                        disabledColor: colorScheme.background,
                        hoverColor: colorScheme.primary,
                        color: colorScheme.background,
                        onPressed: question.isEmpty
                            ? null
                            : () => context.read<ChatBotBloc>().add(
                                  const ChatBotEvent.postQuestion(),
                                ),
                        icon: const Icon(
                          Icons.arrow_upward,
                          size: 30,
                        ),
                      );
                    },
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
