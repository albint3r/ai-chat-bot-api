import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../core/widgets/text/text_title.dart';
import 'avatar_picture.dart';
import 'question_text_field.dart';
import 'questions_suggestion.dart';
import 'top_row_indicators.dart';

class BodyChatBot extends StatelessWidget {
  const BodyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ChatBotBloc>().state;
    if(state.isLoading) return const Center(child: CircularProgressIndicator(),);
    return Column(
      children: [
        const TopRowIndicators(),
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
        const QuestionsSuggestion(),
        const Gap(20),
        const QuestionTextField(),
        const Gap(40),
      ],
    );
  }
}
