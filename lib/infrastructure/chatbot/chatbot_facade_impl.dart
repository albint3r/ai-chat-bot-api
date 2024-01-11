import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:reactive_forms/src/models/models.dart';

import '../../domain/chatbot/i_chat_conversation.dart';
import '../../domain/chatbot/i_chatbot_data_source.dart';
import '../../domain/chatbot/i_chatbot_facade.dart';
import '../../domain/chatbot/question.dart';
import '../../domain/chatbot/suggested_question.dart';

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
      title: "Formación Académica",
      subTitle: "Educación y formación",
      text: "¿Cuál es tu formación académica?",
    ),
    const SuggestedQuestion(
      title: "Especialización en Psicología",
      subTitle: "Áreas especializadas en psicología",
      text: "¿Cuáles son tus áreas de especialización en psicología?",
    ),
    const SuggestedQuestion(
      title: "Transición a Mercadotecnia",
      subTitle: "Cambio de enfoque",
      text:
          "¿Cómo surgió tu interés en la mercadotecnia después de estudiar psicología?",
    ),
    const SuggestedQuestion(
      title: "Experiencia en Mercadotecnia",
      subTitle: "Trayectoria laboral en mercadotecnia",
      text: "¿Cuál es tu experiencia laboral en el campo de la mercadotecnia?",
    ),
    const SuggestedQuestion(
      title: "Ingreso al Mundo de la Programación",
      subTitle: "Motivación y decisión",
      text: "¿Cómo y por qué decidiste ingresar al mundo de la programación?",
    ),
    const SuggestedQuestion(
      title: "Habilidades en Python, Dart y MySQL",
      subTitle: "Competencias destacadas",
      text:
          "¿Cuáles son tus habilidades clave en Python, Dart (Flutter) y MySQL?",
    ),
    const SuggestedQuestion(
      title: "Proyectos Destacados en Programación",
      subTitle: "Logros y contribuciones",
      text: "Háblame sobre tus proyectos más destacados en programación.",
    ),
    const SuggestedQuestion(
      title: "Integración Psicología y Programación",
      subTitle: "Sinergia de conocimientos",
      text:
          "¿Cómo integras tus conocimientos en psicología y mercadotecnia en tu trabajo actual como programador?",
    ),
    const SuggestedQuestion(
      title: "Retos Superados en Carrera Profesional",
      subTitle: "Superación y aprendizaje",
      text:
          "¿Qué retos has enfrentado y superado en tu carrera profesional hasta ahora?",
    ),
    const SuggestedQuestion(
      title: "Actualización en Programación y Tecnología",
      subTitle: "Mantenimiento de conocimientos",
      text:
          "¿Cómo mantienes actualizados tus conocimientos en programación y tecnología?",
    ),
    const SuggestedQuestion(
      title: "Colaboración en Proyectos Multidisciplinarios",
      subTitle: "Experiencia en equipos diversos",
      text:
          "¿Has participado en proyectos colaborativos o en equipos multidisciplinarios?",
    ),
    const SuggestedQuestion(
      title: "Motivación en Desarrollo Móvil con Flutter",
      subTitle: "Razones y pasión",
      text:
          "¿Qué te motivó a especializarte en el desarrollo de aplicaciones móviles con Flutter?",
    ),
    const SuggestedQuestion(
      title: "Experiencia con MySQL en Proyectos",
      subTitle: "Manejo de bases de datos",
      text:
          "Háblame sobre tu experiencia con bases de datos y el manejo de MySQL en tus proyectos.",
    ),
    const SuggestedQuestion(
      title: "Aplicación de Psicología en Programación",
      subTitle: "Enfoque psicológico en desarrollo",
      text:
          "¿Cómo aplicas tus habilidades de psicología en tu enfoque de programación y resolución de problemas?",
    ),
    const SuggestedQuestion(
      title: "Certificaciones en Programación y Especialización",
      subTitle: "Validación de habilidades",
      text:
          "¿Has obtenido certificaciones relevantes en programación o en tus áreas de especialización?",
    ),
    const SuggestedQuestion(
      title: "Planificación y Ejecución de Proyectos",
      subTitle: "Proceso y estrategias",
      text:
          "¿Cuál es tu proceso para planificar y ejecutar un proyecto desde cero?",
    ),
    const SuggestedQuestion(
      title: "Organización y Gestión del Tiempo en Proyectos",
      subTitle: "Eficiencia y plazos",
      text:
          "¿Cómo te mantienes organizado y gestionas tu tiempo en proyectos con plazos ajustados?",
    ),
    const SuggestedQuestion(
      title: "Atracción hacia la Programación",
      subTitle: "Motivaciones personales",
      text:
          "¿Qué te atrajo de la programación que no encontraste en tus estudios previos en psicología y mercadotecnia?",
    ),
    const SuggestedQuestion(
      title: "Experiencia en Enseñanza de Programación",
      subTitle: "Compartir conocimientos",
      text:
          "¿Tienes experiencia en la enseñanza o capacitación en programación o temas relacionados?",
    ),
    const SuggestedQuestion(
      title: "Enfoque en Problemas Complejos de Programación",
      subTitle: "Abordaje y soluciones",
      text:
          "¿Cuál es tu enfoque al enfrentarte a problemas complejos de programación?",
    ),
    const SuggestedQuestion(
      title: "Participación en Conferencias y Eventos",
      subTitle: "Presencia en la comunidad",
      text:
          "¿Has participado en alguna conferencia o evento relacionado con tus áreas de especialización?",
    ),
    const SuggestedQuestion(
      title: "Manejo de Presión y Plazos Ajustados",
      subTitle: "Resiliencia y eficacia",
      text:
          "¿Cómo manejas situaciones de presión y plazos ajustados en tu trabajo diario?",
    ),
    const SuggestedQuestion(
      title: "Aplicación de Técnicas de Marketing Digital en Proyectos",
      subTitle: "Marketing en desarrollo",
      text:
          "Háblame sobre algún proyecto en el que hayas aplicado técnicas de marketing digital.",
    ),
    const SuggestedQuestion(
      title: "Fuentes para Mantenerse Informado en Tecnología",
      subTitle: "Recursos y actualización",
      text:
          "¿Cuáles son tus fuentes principales para mantenerte informado sobre las tendencias en programación y tecnología?",
    ),
    const SuggestedQuestion(
      title: "Abordaje de Retroalimentación en Proyectos",
      subTitle: "Receptividad y mejora continua",
      text:
          "¿Cómo abordas la retroalimentación y los comentarios en tus proyectos?",
    ),
    const SuggestedQuestion(
      title: "Liderazgo de Equipos de Desarrollo",
      subTitle: "Guiando proyectos",
      text: "¿Has liderado equipos de desarrollo en alguno de tus proyectos?",
    ),
  ];

  @override
  FormGroup? get formGroup => _formGroup;

  @override
  Future<List<IChatConversation>> postQuestion({
    String? textQuestion,
  }) async {
    final control = _formGroup.control('question');
    textQuestion = textQuestion ?? control.value as String;
    control.value = '';
    if (textQuestion.isNotEmpty) {
      final answer = await _dataSource.postQuestionQA(textQuestion);
      chatConversation.add(answer);
      return chatConversation;
    }
    return [];
  }

  @override
  List<IChatConversation> addQuestionToConversation({
    String? textQuestion,
  }) {
    final control = _formGroup.control('question');
    textQuestion = textQuestion ?? control.value as String;
    final question = Question(text: textQuestion);
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
