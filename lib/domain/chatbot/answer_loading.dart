import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';
import 'i_chat_conversation.dart';

part 'answer_loading.freezed.dart';

part 'answer_loading.g.dart';

@freezed
class AnswerLoading with _$AnswerLoading implements IChatConversation {
  const factory AnswerLoading({
    required String text,
  }) = _AnswerLoading;

  const AnswerLoading._();

  factory AnswerLoading.fromJson(Json json) => _$AnswerLoadingFromJson(json);
}
