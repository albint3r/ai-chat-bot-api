import 'answer.dart';

abstract interface class IChatBotDataSource {
  Future<Answer> postQuestionQA(String question);
}
