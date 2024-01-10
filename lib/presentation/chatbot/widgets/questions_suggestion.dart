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
              QuestionCard(
                title: 'Centame sobre las tecnologias',
                subTitle: 'de programacion que dominas',
              ),
              Gap(10),
              QuestionCard(
                title: 'Cual fue el reto mas grande',
                subTitle: 'que has tenido en Data Science',
              ),
            ],
          ),
        ),
        Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QuestionCard(
              title: 'Al dejar marketing',
              subTitle: 'que te motivo ir a la programacion',
            ),
            Gap(10),
            QuestionCard(
              title: 'En cuestion de bases de datos',
              subTitle: 'cuales conoces y dominas',
            ),
          ],
        )
      ],
    );
  }
}
