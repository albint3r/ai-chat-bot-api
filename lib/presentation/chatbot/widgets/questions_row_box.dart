import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../aplication/chatbot/chatbot_bloc.dart';
import '../../../domain/chatbot/i_chat_conversation.dart';
import '../../../domain/chatbot/suggested_question.dart';
import '../../core/theme/const_values.dart';
import 'question_card.dart';

class QuestionsRowBox extends StatelessWidget {
  const QuestionsRowBox({super.key});

  List<Widget> _getQuestionsCards(
    BuildContext context,
    List<IChatConversation> questions,
  ) {
    return questions.map((question) {
      if (question is SuggestedQuestion) {
        return QuestionCard(
          title: question.title,
          subTitle: question.subTitle,
          onPressed: () => context.read<ChatBotBloc>().add(
                ChatBotEvent.postQuestion(
                  textQuestion: question.text,
                ),
              ),
        );
      }
      return const QuestionCard(title: '', subTitle: '');
    }).toList();
  }

  Expanded _getListViewCardFormat(List<Widget> questionCards) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: questionCards
            .map(
              (question) => Padding(
                padding: const EdgeInsets.all(padding),
                child: question,
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatBotBloc>().state;
    final suggestedQuestions = chat.suggestedQuestions;
    final width = MediaQuery.of(context).size.width;
    final questionCards = _getQuestionsCards(
      context,
      suggestedQuestions,
    );
    if (width <= screenBreakingPoint) {
      return _getListViewCardFormat(questionCards);
    }

    return Column(
      children: [
        SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              questionCards[0],
              const Gap(padding),
              questionCards[1],
            ],
          ),
        ),
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            questionCards[2],
            const Gap(padding),
            questionCards[3],
          ],
        ),
      ],
    );
  }
}
