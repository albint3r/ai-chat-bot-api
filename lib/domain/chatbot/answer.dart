import 'package:freezed_annotation/freezed_annotation.dart';

import '../core/types.dart';

part 'answer.freezed.dart';

part 'answer.g.dart';

@freezed
class Answer with _$Answer {
  const factory Answer({
    required String text,
  }) = _Answer;

  const Answer._();

  factory Answer.fromJson(Json json) => _$AnswerFromJson(json);
}
