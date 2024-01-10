import 'package:flutter/material.dart';

import 'top_row_indicators.dart';

class BodyChatBot extends StatelessWidget {
  const BodyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopRowIndicators(),
        CircleAvatar(
          child: Text('T'),
        ),
        Text('What want to know about Alberto Professional experience?'),
      ],
    );
  }
}
