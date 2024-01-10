import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'widgets/body_chatbot.dart';

@RoutePage()
class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BodyChatBot(),
    );
  }
}
