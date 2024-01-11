import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../aplication/chatbot/chatbot_bloc.dart';
import '../../injectables.dart';
import 'widgets/body_chatbot.dart';

@RoutePage()
class ChatBotPage extends StatelessWidget {
  const ChatBotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChatBotBloc>()
        ..add(
          const ChatBotEvent.started(),
        ),
      child: const SafeArea(
        child: Scaffold(
          body: BodyChatBot(),
        ),
      ),
    );
  }
}
