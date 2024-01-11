part of 'chatbot_bloc.dart';

@freezed
class ChatBotState with _$ChatBotState {
  const factory ChatBotState({
    required bool isLoading,
    required List<IChatConversation> chatConversation,
    FormGroup? formGroup,
  }) = _ChatBotState;

  factory ChatBotState.initial() => const ChatBotState(
        isLoading: true,
        chatConversation: [
          Question(text: '¿En qué área te especializaste durante tus estudios universitarios?'),
          Answer(text: 'Me especialicé en Desarrollo de Software y Sistemas Distribuidos.'),
          Question(text: 'Eso suena fascinante. ¿Cuál fue tu proyecto más destacado?'),
          Answer(text: 'Trabajé en un sistema de reconocimiento facial para mejorar la seguridad en entornos públicos.'),
          Question(text: '¡Impresionante! ¿Cómo abordaste los desafíos en ese proyecto?'),
          Answer(text: 'Utilizamos algoritmos avanzados de aprendizaje profundo y colaboración interdisciplinaria para superar los desafíos técnicos.'),
          Question(text: 'Eso suena fascinante. ¿Cuál fue tu proyecto más destacado?'),
          Answer(text: 'Trabajé en un sistema de reconocimiento facial para mejorar la seguridad en entornos públicos.'),
          Question(text: '¡Impresionante! ¿Cómo abordaste los desafíos en ese proyecto?'),
          Answer(text: 'Utilizamos algoritmos avanzados de aprendizaje profundo y colaboración interdisciplinaria para superar los desafíos técnicos.'),
          Question(text: '¡Impresionante! ¿Cómo abordaste los desafíos en ese proyecto?'),
          Answer(text: 'Utilizamos algoritmos avanzados de aprendizaje profundo y colaboración interdisciplinaria para superar los desafíos técnicos.'),
          Question(text: 'Eso suena fascinante. ¿Cuál fue tu proyecto más destacado?'),
          Answer(text: 'Trabajé en un sistema de reconocimiento facial para mejorar la seguridad en entornos públicos.'),
          Question(text: '¡Impresionante! ¿Cómo abordaste los desafíos en ese proyecto?'),
          Answer(text: 'Utilizamos algoritmos avanzados de aprendizaje profundo y colaboración interdisciplinaria para superar los desafíos técnicos.'),
        ]
    ,
      );
}
