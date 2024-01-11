import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/chatbot/answer.dart';
import '../../domain/chatbot/i_chatbot_data_source.dart';
import '../../domain/core/types.dart';

@Injectable(as: IChatBotDataSource)
class ChatBotDataSourceImpl implements IChatBotDataSource {
  ChatBotDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<Answer> postQuestionQA(String question) async {
    final response = await _dio.post(
      '/chatbot/v1/qa-chatbot',
      data: {
        'text': question,
      },
    );
    final data = response.data as Json;
    return Answer.fromJson(data);
  }
}
