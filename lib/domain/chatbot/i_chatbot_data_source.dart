abstract interface class IChatBotDataSource {
  Future<void> postQuestionQA(String question);
}
