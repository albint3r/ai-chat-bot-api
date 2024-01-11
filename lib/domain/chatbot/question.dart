import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';
import 'i_chat_conversation.dart';

part 'question.freezed.dart';

part 'question.g.dart';

@freezed
class Question with _$Question implements IChatConversation {
  const factory Question({
    required String text,
  }) = _Question;

  const Question._();

  factory Question.fromJson(Json json) => _$QuestionFromJson(json);
}
