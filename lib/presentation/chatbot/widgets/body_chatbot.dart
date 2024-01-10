import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/widgets/cards/custom_primary_card.dart';
import '../../core/widgets/text/text_title.dart';
import 'avatar_picture.dart';
import 'questions_suggestion.dart';
import 'top_row_indicators.dart';

class BodyChatBot extends StatelessWidget {
  const BodyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopRowIndicators(),
        const AvatarPicture(),
        TextTitle.h1('What you want to know about Alberto?'),
        const QuestionsSuggestion()
      ],
    );
  }
}
