import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import 'conversation_area.dart';
import 'query_text_field.dart';
import 'top_row_indicators.dart';
import 'wellcome_elements.dart';

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
        const Gap(10),
        const QueryTextField(),
        const Gap(40),
      ],
    );
  }
}
