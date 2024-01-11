// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatbot_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChatBotEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String? textQuestion) postQuestion,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String? textQuestion)? postQuestion,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String? textQuestion)? postQuestion,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PostQuestion value) postQuestion,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PostQuestion value)? postQuestion,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PostQuestion value)? postQuestion,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatBotEventCopyWith<$Res> {
  factory $ChatBotEventCopyWith(
          ChatBotEvent value, $Res Function(ChatBotEvent) then) =
      _$ChatBotEventCopyWithImpl<$Res, ChatBotEvent>;
}

/// @nodoc
class _$ChatBotEventCopyWithImpl<$Res, $Val extends ChatBotEvent>
    implements $ChatBotEventCopyWith<$Res> {
  _$ChatBotEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$StartedImplCopyWith<$Res> {
  factory _$$StartedImplCopyWith(
          _$StartedImpl value, $Res Function(_$StartedImpl) then) =
      __$$StartedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$StartedImplCopyWithImpl<$Res>
    extends _$ChatBotEventCopyWithImpl<$Res, _$StartedImpl>
    implements _$$StartedImplCopyWith<$Res> {
  __$$StartedImplCopyWithImpl(
      _$StartedImpl _value, $Res Function(_$StartedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$StartedImpl implements _Started {
  const _$StartedImpl();

  @override
  String toString() {
    return 'ChatBotEvent.started()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$StartedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String? textQuestion) postQuestion,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String? textQuestion)? postQuestion,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String? textQuestion)? postQuestion,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PostQuestion value) postQuestion,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PostQuestion value)? postQuestion,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PostQuestion value)? postQuestion,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements ChatBotEvent {
  const factory _Started() = _$StartedImpl;
}

/// @nodoc
abstract class _$$PostQuestionImplCopyWith<$Res> {
  factory _$$PostQuestionImplCopyWith(
          _$PostQuestionImpl value, $Res Function(_$PostQuestionImpl) then) =
      __$$PostQuestionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? textQuestion});
}

/// @nodoc
class __$$PostQuestionImplCopyWithImpl<$Res>
    extends _$ChatBotEventCopyWithImpl<$Res, _$PostQuestionImpl>
    implements _$$PostQuestionImplCopyWith<$Res> {
  __$$PostQuestionImplCopyWithImpl(
      _$PostQuestionImpl _value, $Res Function(_$PostQuestionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? textQuestion = freezed,
  }) {
    return _then(_$PostQuestionImpl(
      textQuestion: freezed == textQuestion
          ? _value.textQuestion
          : textQuestion // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PostQuestionImpl implements _PostQuestion {
  const _$PostQuestionImpl({this.textQuestion});

  @override
  final String? textQuestion;

  @override
  String toString() {
    return 'ChatBotEvent.postQuestion(textQuestion: $textQuestion)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostQuestionImpl &&
            (identical(other.textQuestion, textQuestion) ||
                other.textQuestion == textQuestion));
  }

  @override
  int get hashCode => Object.hash(runtimeType, textQuestion);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostQuestionImplCopyWith<_$PostQuestionImpl> get copyWith =>
      __$$PostQuestionImplCopyWithImpl<_$PostQuestionImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function(String? textQuestion) postQuestion,
  }) {
    return postQuestion(textQuestion);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function(String? textQuestion)? postQuestion,
  }) {
    return postQuestion?.call(textQuestion);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function(String? textQuestion)? postQuestion,
    required TResult orElse(),
  }) {
    if (postQuestion != null) {
      return postQuestion(textQuestion);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(_PostQuestion value) postQuestion,
  }) {
    return postQuestion(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(_PostQuestion value)? postQuestion,
  }) {
    return postQuestion?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(_PostQuestion value)? postQuestion,
    required TResult orElse(),
  }) {
    if (postQuestion != null) {
      return postQuestion(this);
    }
    return orElse();
  }
}

abstract class _PostQuestion implements ChatBotEvent {
  const factory _PostQuestion({final String? textQuestion}) =
      _$PostQuestionImpl;

  String? get textQuestion;
  @JsonKey(ignore: true)
  _$$PostQuestionImplCopyWith<_$PostQuestionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ChatBotState {
  bool get isLoading => throw _privateConstructorUsedError;
  List<IChatConversation> get chatConversation =>
      throw _privateConstructorUsedError;
  List<IChatConversation> get suggestedQuestions =>
      throw _privateConstructorUsedError;
  FormGroup? get formGroup => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChatBotStateCopyWith<ChatBotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatBotStateCopyWith<$Res> {
  factory $ChatBotStateCopyWith(
          ChatBotState value, $Res Function(ChatBotState) then) =
      _$ChatBotStateCopyWithImpl<$Res, ChatBotState>;
  @useResult
  $Res call(
      {bool isLoading,
      List<IChatConversation> chatConversation,
      List<IChatConversation> suggestedQuestions,
      FormGroup? formGroup});
}

/// @nodoc
class _$ChatBotStateCopyWithImpl<$Res, $Val extends ChatBotState>
    implements $ChatBotStateCopyWith<$Res> {
  _$ChatBotStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? chatConversation = null,
    Object? suggestedQuestions = null,
    Object? formGroup = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      chatConversation: null == chatConversation
          ? _value.chatConversation
          : chatConversation // ignore: cast_nullable_to_non_nullable
              as List<IChatConversation>,
      suggestedQuestions: null == suggestedQuestions
          ? _value.suggestedQuestions
          : suggestedQuestions // ignore: cast_nullable_to_non_nullable
              as List<IChatConversation>,
      formGroup: freezed == formGroup
          ? _value.formGroup
          : formGroup // ignore: cast_nullable_to_non_nullable
              as FormGroup?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatBotStateImplCopyWith<$Res>
    implements $ChatBotStateCopyWith<$Res> {
  factory _$$ChatBotStateImplCopyWith(
          _$ChatBotStateImpl value, $Res Function(_$ChatBotStateImpl) then) =
      __$$ChatBotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      List<IChatConversation> chatConversation,
      List<IChatConversation> suggestedQuestions,
      FormGroup? formGroup});
}

/// @nodoc
class __$$ChatBotStateImplCopyWithImpl<$Res>
    extends _$ChatBotStateCopyWithImpl<$Res, _$ChatBotStateImpl>
    implements _$$ChatBotStateImplCopyWith<$Res> {
  __$$ChatBotStateImplCopyWithImpl(
      _$ChatBotStateImpl _value, $Res Function(_$ChatBotStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? chatConversation = null,
    Object? suggestedQuestions = null,
    Object? formGroup = freezed,
  }) {
    return _then(_$ChatBotStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      chatConversation: null == chatConversation
          ? _value._chatConversation
          : chatConversation // ignore: cast_nullable_to_non_nullable
              as List<IChatConversation>,
      suggestedQuestions: null == suggestedQuestions
          ? _value._suggestedQuestions
          : suggestedQuestions // ignore: cast_nullable_to_non_nullable
              as List<IChatConversation>,
      formGroup: freezed == formGroup
          ? _value.formGroup
          : formGroup // ignore: cast_nullable_to_non_nullable
              as FormGroup?,
    ));
  }
}

/// @nodoc

class _$ChatBotStateImpl implements _ChatBotState {
  const _$ChatBotStateImpl(
      {required this.isLoading,
      required final List<IChatConversation> chatConversation,
      required final List<IChatConversation> suggestedQuestions,
      this.formGroup})
      : _chatConversation = chatConversation,
        _suggestedQuestions = suggestedQuestions;

  @override
  final bool isLoading;
  final List<IChatConversation> _chatConversation;
  @override
  List<IChatConversation> get chatConversation {
    if (_chatConversation is EqualUnmodifiableListView)
      return _chatConversation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chatConversation);
  }

  final List<IChatConversation> _suggestedQuestions;
  @override
  List<IChatConversation> get suggestedQuestions {
    if (_suggestedQuestions is EqualUnmodifiableListView)
      return _suggestedQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestedQuestions);
  }

  @override
  final FormGroup? formGroup;

  @override
  String toString() {
    return 'ChatBotState(isLoading: $isLoading, chatConversation: $chatConversation, suggestedQuestions: $suggestedQuestions, formGroup: $formGroup)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatBotStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            const DeepCollectionEquality()
                .equals(other._chatConversation, _chatConversation) &&
            const DeepCollectionEquality()
                .equals(other._suggestedQuestions, _suggestedQuestions) &&
            (identical(other.formGroup, formGroup) ||
                other.formGroup == formGroup));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isLoading,
      const DeepCollectionEquality().hash(_chatConversation),
      const DeepCollectionEquality().hash(_suggestedQuestions),
      formGroup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatBotStateImplCopyWith<_$ChatBotStateImpl> get copyWith =>
      __$$ChatBotStateImplCopyWithImpl<_$ChatBotStateImpl>(this, _$identity);
}

abstract class _ChatBotState implements ChatBotState {
  const factory _ChatBotState(
      {required final bool isLoading,
      required final List<IChatConversation> chatConversation,
      required final List<IChatConversation> suggestedQuestions,
      final FormGroup? formGroup}) = _$ChatBotStateImpl;

  @override
  bool get isLoading;
  @override
  List<IChatConversation> get chatConversation;
  @override
  List<IChatConversation> get suggestedQuestions;
  @override
  FormGroup? get formGroup;
  @override
  @JsonKey(ignore: true)
  _$$ChatBotStateImplCopyWith<_$ChatBotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
