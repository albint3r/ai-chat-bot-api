import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import 'avatar_picture.dart';
import 'top_row_indicators.dart';

class BodyChatBot extends StatelessWidget {
  const BodyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        TopRowIndicators(),
        AvatarPicture(),
        Text('What want to know about Alberto?'),
      ],
    );
  }
}
