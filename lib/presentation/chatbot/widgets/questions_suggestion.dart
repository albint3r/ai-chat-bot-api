import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'question_card.dart';

class QuestionsSuggestion extends StatelessWidget {
  const QuestionsSuggestion({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QuestionCard(),
              Gap(10),
              QuestionCard(),
            ],
          ),
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionCard(),
            Gap(10),
            QuestionCard(),
          ],
        )
      ],
    );
  }
}
