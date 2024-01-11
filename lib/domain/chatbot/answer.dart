import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';
import 'i_chat_conversation.dart';

part 'answer.freezed.dart';

part 'answer.g.dart';

@freezed
class Answer with _$Answer implements IChatConversation {
  const factory Answer({
    required String text,
  }) = _Answer;

  const Answer._();

  factory Answer.fromJson(Json json) => _$AnswerFromJson(json);
}
