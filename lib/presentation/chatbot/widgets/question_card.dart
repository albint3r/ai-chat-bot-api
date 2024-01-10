import 'package:flutter/material.dart';

import '../../core/widgets/cards/custom_primary_card.dart';
import '../../core/widgets/text/text_body.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  double _getSizeScreen(double width) {
    if (width <= 700) return width * 0.45;
    return 325;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final sizeScreen = _getSizeScreen(width);
    return CustomPrimaryCard(
      width: sizeScreen,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBody(title),
            TextBody(
              subTitle,
              color: colorScheme.secondaryContainer,
            ),
          ],
        ),
      ),
    );
  }
}
