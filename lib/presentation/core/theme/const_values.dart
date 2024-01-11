import '../../../domain/chatbot/suggested_question.dart';

const borderRadius = 15.0;
const padding = 5.0;
const borderWidth = 1.0;
const lateralContainerWith = 260.0;
const screenBreakingPoint = 700;
const textFieldWidth = 700.0;
// Font Size:
const h1 = 25.0;
const h2 = 20.0;
const h3 = 15.0;
const bodyMedium = 12.0;
const bodySmall = 10.0;
const allQuestion = {
  'alberto-cv': <SuggestedQuestion>[
    SuggestedQuestion(
      title: "Formación Académica",
      subTitle: "Educación y formación",
      text: "¿Cuál es tu formación académica?",
    ),
    SuggestedQuestion(
      title: "Especialización en Psicología",
      subTitle: "Áreas especializadas en psicología",
      text: "¿Cuáles son tus áreas de especialización en psicología?",
    ),
    SuggestedQuestion(
      title: "Transición a Mercadotecnia",
      subTitle: "Cambio de enfoque",
      text:
          "¿Cómo surgió tu interés en la mercadotecnia después de estudiar psicología?",
    ),
    SuggestedQuestion(
      title: "Experiencia en Mercadotecnia",
      subTitle: "Trayectoria laboral en mercadotecnia",
      text: "¿Cuál es tu experiencia laboral en el campo de la mercadotecnia?",
    ),
    SuggestedQuestion(
      title: "Ingreso al Mundo de la Programación",
      subTitle: "Motivación y decisión",
      text: "¿Cómo y por qué decidiste ingresar al mundo de la programación?",
    ),
    SuggestedQuestion(
      title: "Habilidades en Python, Dart y MySQL",
      subTitle: "Competencias destacadas",
      text:
          "¿Cuáles son tus habilidades clave en Python, Dart (Flutter) y MySQL?",
    ),
    SuggestedQuestion(
      title: "Proyectos Destacados en Programación",
      subTitle: "Logros y contribuciones",
      text: "Háblame sobre tus proyectos más destacados en programación.",
    ),
    SuggestedQuestion(
      title: "Integración Psicología y Programación",
      subTitle: "Sinergia de conocimientos",
      text:
          "¿Cómo integras tus conocimientos en psicología y mercadotecnia en tu trabajo actual como programador?",
    ),
    SuggestedQuestion(
      title: "Retos Superados en Carrera Profesional",
      subTitle: "Superación y aprendizaje",
      text:
          "¿Qué retos has enfrentado y superado en tu carrera profesional hasta ahora?",
    ),
    SuggestedQuestion(
      title: "Actualización en Programación y Tecnología",
      subTitle: "Mantenimiento de conocimientos",
      text:
          "¿Cómo mantienes actualizados tus conocimientos en programación y tecnología?",
    ),
    SuggestedQuestion(
      title: "Colaboración en Proyectos Multidisciplinarios",
      subTitle: "Experiencia en equipos diversos",
      text:
          "¿Has participado en proyectos colaborativos o en equipos multidisciplinarios?",
    ),
    SuggestedQuestion(
      title: "Motivación en Desarrollo Móvil con Flutter",
      subTitle: "Razones y pasión",
      text:
          "¿Qué te motivó a especializarte en el desarrollo de aplicaciones móviles con Flutter?",
    ),
    SuggestedQuestion(
      title: "Experiencia con MySQL en Proyectos",
      subTitle: "Manejo de bases de datos",
      text:
          "Háblame sobre tu experiencia con bases de datos y el manejo de MySQL en tus proyectos.",
    ),
    SuggestedQuestion(
      title: "Aplicación de Psicología en Programación",
      subTitle: "Enfoque psicológico en desarrollo",
      text:
          "¿Cómo aplicas tus habilidades de psicología en tu enfoque de programación y resolución de problemas?",
    ),
    SuggestedQuestion(
      title: "Certificaciones en Programación y Especialización",
      subTitle: "Validación de habilidades",
      text:
          "¿Has obtenido certificaciones relevantes en programación o en tus áreas de especialización?",
    ),
    SuggestedQuestion(
      title: "Planificación y Ejecución de Proyectos",
      subTitle: "Proceso y estrategias",
      text:
          "¿Cuál es tu proceso para planificar y ejecutar un proyecto desde cero?",
    ),
    SuggestedQuestion(
      title: "Organización y Gestión del Tiempo en Proyectos",
      subTitle: "Eficiencia y plazos",
      text:
          "¿Cómo te mantienes organizado y gestionas tu tiempo en proyectos con plazos ajustados?",
    ),
    SuggestedQuestion(
      title: "Atracción hacia la Programación",
      subTitle: "Motivaciones personales",
      text:
          "¿Qué te atrajo de la programación que no encontraste en tus estudios previos en psicología y mercadotecnia?",
    ),
    SuggestedQuestion(
      title: "Experiencia en Enseñanza de Programación",
      subTitle: "Compartir conocimientos",
      text:
          "¿Tienes experiencia en la enseñanza o capacitación en programación o temas relacionados?",
    ),
    SuggestedQuestion(
      title: "Enfoque en Problemas Complejos de Programación",
      subTitle: "Abordaje y soluciones",
      text:
          "¿Cuál es tu enfoque al enfrentarte a problemas complejos de programación?",
    ),
    SuggestedQuestion(
      title: "Participación en Conferencias y Eventos",
      subTitle: "Presencia en la comunidad",
      text:
          "¿Has participado en alguna conferencia o evento relacionado con tus áreas de especialización?",
    ),
    SuggestedQuestion(
      title: "Manejo de Presión y Plazos Ajustados",
      subTitle: "Resiliencia y eficacia",
      text:
          "¿Cómo manejas situaciones de presión y plazos ajustados en tu trabajo diario?",
    ),
    SuggestedQuestion(
      title: "Aplicación de Técnicas de Marketing Digital en Proyectos",
      subTitle: "Marketing en desarrollo",
      text:
          "Háblame sobre algún proyecto en el que hayas aplicado técnicas de marketing digital.",
    ),
    SuggestedQuestion(
      title: "Fuentes para Mantenerse Informado en Tecnología",
      subTitle: "Recursos y actualización",
      text:
          "¿Cuáles son tus fuentes principales para mantenerte informado sobre las tendencias en programación y tecnología?",
    ),
    SuggestedQuestion(
      title: "Abordaje de Retroalimentación en Proyectos",
      subTitle: "Receptividad y mejora continua",
      text:
          "¿Cómo abordas la retroalimentación y los comentarios en tus proyectos?",
    ),
    SuggestedQuestion(
      title: "Liderazgo de Equipos de Desarrollo",
      subTitle: "Guiando proyectos",
      text: "¿Has liderado equipos de desarrollo en alguno de tus proyectos?",
    ),
  ]
};
