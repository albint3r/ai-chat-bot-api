import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import 'conversation_card.dart';

class ConversationArea extends StatefulWidget {
  const ConversationArea({super.key});

  @override
  State<ConversationArea> createState() => _ConversationAreaState();
}

class _ConversationAreaState extends State<ConversationArea> {
  final ScrollController _scrollController = ScrollController();

  void _scrollDownConversation() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 150,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    return BlocListener<ChatBotBloc, ChatBotState>(
      listenWhen: (pre, curr) => pre.chatConversation != curr.chatConversation,
      listener: (_, __) => _scrollDownConversation(),
      child: SizedBox(
        width: 680,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: chat.chatConversation.length,
          itemBuilder: (_, i) {
            final chatConversation = chat.chatConversation[i];
            return ConversationCard(chatConversation: chatConversation);
          },
        ),
      ),
    );
  }
}
