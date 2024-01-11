import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import 'conversation_card.dart';

class ConversationArea extends StatelessWidget {
  const ConversationArea({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    return SizedBox(
      width: 680,
      child: ListView.builder(
        itemCount: chat.chatConversation.length,
        itemBuilder: (context, i) {
          final chatConversation = chat.chatConversation[i];
          return ConversationCard(chatConversation: chatConversation);
        },
      ),
    );
  }
}
