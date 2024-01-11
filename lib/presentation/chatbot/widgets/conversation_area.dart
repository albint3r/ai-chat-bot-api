import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../core/widgets/text/text_body.dart';

class ConversationArea extends StatelessWidget {
  const ConversationArea({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    return ListView.builder(
      itemCount: chat.answers.length,
      itemBuilder: (context, i) {
        return TextBody(chat.answers[i].text);
      },
    );
  }
}
