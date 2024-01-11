import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../core/widgets/text/text_title.dart';
import 'avatar_picture.dart';
import 'questions_row_box.dart';

class WellComeElements extends StatelessWidget {
  const WellComeElements({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AvatarPicture(),
              const Gap(20),
              TextTitle.h1('What you want to know about Alberto?'),
            ],
          ),
        ),
        const QuestionsRowBox(),
      ],
    );
  }
}
