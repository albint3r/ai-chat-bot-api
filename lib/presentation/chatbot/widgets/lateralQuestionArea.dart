import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../core/theme/const_values.dart';
import '../../core/widgets/text/text_title.dart';
import 'question_card.dart';

class LateralQuestionArea extends StatelessWidget {
  const LateralQuestionArea({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    final lateralQuestion = allQuestion['alberto-cv'] ?? [];
    return Container(
      height: size.height,
      width: lateralContainerWith,
      decoration: BoxDecoration(
        color: colorScheme.onSecondary,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(padding),
            child: TextTitle.h3('Suggested Questions'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lateralQuestion.length,
              itemBuilder: (_, i) {
                final question = lateralQuestion[i];
                return Padding(
                  padding: const EdgeInsets.all(padding),
                  child: QuestionCard(
                    title: question.title,
                    subTitle: question.subTitle,
                    onPressed: () => context.read<ChatBotBloc>().add(
                          ChatBotEvent.postQuestion(
                            textQuestion: question.text,
                          ),
                        ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(padding),
            child: Card(
              color: colorScheme.onSecondary.withOpacity(.05),
              child: SizedBox(
                height: 200,
                width: lateralContainerWith,
                child: Column(
                  children: [
                    const Gap(padding * 2),
                    TextTitle.h2('Contact Information:'),
                    const Gap(padding * 8),
                    Expanded(
                      child: Column(
                        children: [
                          TextTitle.h3('Phone: 333-9548781'),
                          TextTitle.h3('Email: albint3r@gmail.com'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
