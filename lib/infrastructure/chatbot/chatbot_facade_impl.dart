import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';

import '../../domain/chatbot/i_chat_conversation.dart';
import '../../domain/chatbot/i_chatbot_data_source.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';
import '../../domain/chatbot/question.dart';
import '../../domain/chatbot/suggested_question.dart';

import 'dart:math';

@Injectable(as: IChatBotFacade)
class ChatBotFacadeImpl implements IChatBotFacade {
  ChatBotFacadeImpl(this._dataSource);

  final chatConversation = <IChatConversation>[];
  final IChatBotDataSource _dataSource;

  final _formGroup = FormGroup({
    'question': FormControl<String>(value: ''),
  });

  final _suggestedQuestions = <SuggestedQuestion>[
    const SuggestedQuestion(
      title: "Desarrollo de Aplicaciones Móviles",
      subTitle: "Tendencias y tecnologías emergentes",
      text:
          "¿Cuáles son las tendencias actuales en el desarrollo de aplicaciones móviles?",
    ),
    const SuggestedQuestion(
      title: "Gestión de Proyectos de Software",
      subTitle: "Metodologías ágiles y eficiencia",
      text:
          "¿Cómo implementas metodologías ágiles para optimizar la gestión de proyectos de software?",
    ),
    const SuggestedQuestion(
      title: "Seguridad en Desarrollo de Software",
      subTitle: "Garantizando la protección de datos",
      text:
          "¿Cuáles son las estrategias clave para garantizar la seguridad en el desarrollo de software?",
    ),
    const SuggestedQuestion(
      title: "Interfaces de Usuario Efectivas",
      subTitle: "Creación y experiencia del usuario",
      text:
          "¿Cómo diseñar interfaces de usuario efectivas para mejorar la experiencia del usuario?",
    ),
    const SuggestedQuestion(
      title: "Innovación en Inteligencia Artificial",
      subTitle: "Aplicaciones y aprendizaje automático",
      text:
          "¿Cómo implementas soluciones de inteligencia artificial y aprendizaje automático en tus proyectos?",
    ),
    const SuggestedQuestion(
      title: "Compatibilidad en Desarrollo Móvil",
      subTitle: "Adaptabilidad a diferentes dispositivos",
      text:
          "¿Cómo manejas la compatibilidad y adaptabilidad de las aplicaciones móviles a diferentes dispositivos y sistemas operativos?",
    ),
    const SuggestedQuestion(
      title: "Desarrollo de Bases de Datos",
      subTitle: "Experiencia con MySQL",
      text:
          "¿Cuál es tu experiencia en la creación y gestión de bases de datos utilizando MySQL en proyectos de desarrollo?",
    ),
    const SuggestedQuestion(
      title: "Desarrollo Web y Tecnologías",
      subTitle: "Selección de tecnologías adecuadas",
      text:
          "¿Cómo evalúas y seleccionas las tecnologías adecuadas para proyectos de desarrollo web?",
    ),
    const SuggestedQuestion(
      title: "Colaboración en Proyectos Open Source",
      subTitle: "Contribuciones a comunidades de desarrollo",
      text:
          "¿Has participado en proyectos de código abierto o contribuido a comunidades de desarrollo? Cuéntame sobre tu experiencia.",
    ),
    const SuggestedQuestion(
      title: "Desarrollo de Aplicaciones con Dart y Flutter",
      subTitle: "Experiencia y proyectos destacados",
      text:
          "Háblame sobre tu experiencia en el desarrollo de aplicaciones móviles con Dart y Flutter. ¿Cuáles son tus proyectos más destacados?",
    ),
  ];

  @override
  FormGroup? get formGroup => _formGroup;

  @override
  Future<List<IChatConversation>> postQuestion() async {
    final control = _formGroup.control('question');
    final question = control.value as String;
    control.value = '';
    if (question.isNotEmpty) {
      final answer = await _dataSource.postQuestionQA(question);
      chatConversation.add(answer);
      return chatConversation;
    }
    return [];
  }

  @override
  List<IChatConversation> addQuestionToConversation() {
    final control = _formGroup.control('question');
    final question = Question(text: control.value as String);
    chatConversation.add(question);
    return chatConversation;
  }

  @override
  List<IChatConversation> getRandomNSuggestedQuestion({int n = 4}) {
    final rng = Random();
    final Set suggestedQuestions = {};
    while (suggestedQuestions.length < n) {
      final randIndex = rng.nextInt(_suggestedQuestions.length);
      suggestedQuestions.add(_suggestedQuestions[randIndex]);
    }
    return List.from(suggestedQuestions);
  }
}
