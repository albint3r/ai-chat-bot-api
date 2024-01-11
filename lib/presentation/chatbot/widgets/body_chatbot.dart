import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:tobe_cv_flutter/presentation/chatbot/widgets/wellcome_elements.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../core/widgets/text/text_title.dart';
import 'avatar_picture.dart';
import 'conversation_area.dart';
import 'question_text_field.dart';
import 'questions_suggestion.dart';
import 'top_row_indicators.dart';

class BodyChatBot extends StatelessWidget {
  const BodyChatBot({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    if (chat.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Column(
      children: [
        const TopRowIndicators(),
        const Gap(20),
        if (chat.chatConversation.isNotEmpty)
          const Expanded(
            child: ConversationArea(),
          )
        else
          const Expanded(
            child: WellComeElements(),
          ),
        const QuestionTextField(),
        const Gap(40),
      ],
    );
  }
}
