import 'package:flutter/material.dart';

import '../../core/theme/const_values.dart';
import '../../core/widgets/cards/custom_primary_card.dart';
import '../../core/widgets/text/text_body.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.title,
    required this.subTitle,
    this.cardSize = 325,
    this.onPressed,
  });

  final String title;
  final String subTitle;
  final double cardSize;
  final void Function()? onPressed;

  double _getCardRelativeWidth(double width) {
    if (width <= screenBreakingPoint) return width;
    return cardSize;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final width = MediaQuery.of(context).size.width;
    final relativeWith = _getCardRelativeWidth(width);
    return CustomPrimaryCard(
      onPressed: onPressed,
      width: relativeWith,
      child: Padding(
        padding: const EdgeInsets.all(padding),
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
