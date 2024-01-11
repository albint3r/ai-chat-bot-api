import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../domain/chatbot/answer.dart';
import '../../../domain/chatbot/i_chat_conversation.dart';
import '../../core/widgets/text/text_body.dart';
import '../../core/widgets/text/text_title.dart';
import '../../gen/assets.gen.dart';

class SingleChatLog extends StatelessWidget {
  const SingleChatLog({
    super.key,
    required this.chatConversation,
  });

  final IChatConversation chatConversation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (chatConversation is Answer)
                CircleAvatar(
                  radius: 15,
                  backgroundImage: Assets.images.avatar.provider(),
                )
              else
                CircleAvatar(
                  backgroundColor: colorScheme.primary,
                  radius: 15,
                  child: const TextBody('G'),
                ),
              const Gap(10),
              TextTitle.h3(
                chatConversation is Answer ? 'Alberto Ortiz:' : 'Guess:',
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
  }
}
