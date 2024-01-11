import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../../domain/chatbot/answer.dart';
import '../../core/widgets/text/text_body.dart';
import '../../core/widgets/text/text_title.dart';
import '../../gen/assets.gen.dart';

class ConversationArea extends StatelessWidget {
  const ConversationArea({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    return SizedBox(
      width: 700,
      child: ListView.builder(
        itemCount: chat.chatConversation.length,
        itemBuilder: (context, i) {
          final chatConversation = chat.chatConversation[i];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: Assets.images.avatar.provider(),
                    ),
                    const Gap(10),
                    TextTitle.h3(
                      chatConversation is Answer ? 'Alberto Ortiz' : 'Inviate',
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Gap(40),
                    Expanded(
                      child: TextBody(chatConversation.text),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
