import 'package:flutter/material.dart';

import '../../core/widgets/cards/custom_primary_card.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key});

  double _getSizeScreen(double width) {
    if (width <= 700) return width * 0.45;
    return 325;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final sizeScreen = _getSizeScreen(width);
    return CustomPrimaryCard(
      width: sizeScreen,
    );
  }
}
