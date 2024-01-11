import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';
import 'i_chat_conversation.dart';

part 'suggested_question.freezed.dart';

part 'suggested_question.g.dart';

@freezed
class SuggestedQuestion with _$SuggestedQuestion implements IChatConversation {
  const factory SuggestedQuestion({
    required String text,
    required String title,
    required String subTitle,
  }) = _SuggestedQuestion;

  const SuggestedQuestion._();

  factory SuggestedQuestion.fromJson(Json json) =>
      _$SuggestedQuestionFromJson(json);

  @override
  String get text => throw UnimplementedError();
}
