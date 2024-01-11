import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../domain/chatbot/i_chatbot_data_source.dart';

@Injectable(as: IChatBotDataSource)
class ChatBotDataSourceImpl implements IChatBotDataSource {
  ChatBotDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> postQuestionQA(String question) async {
    final response = await _dio.post(
      '/chatbot/v1/qa-chatbot',
      data: {
        'text': question,
      },
    );
    print('*-' * 100);
    print('Response-> $response');
    print('*-' * 100);
  }
}
