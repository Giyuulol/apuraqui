import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  // Função Container/Superfície: bases neutras para fundos e componentes.
  static const Color surfaceLightPrimary = Color(0xFFFFFFFF); // --pure-0
  static const Color surfaceLightAlternative = Color(0xFFF8F8F8); // --gray-2
  static const Color surfaceDarkPrimary = Color(
    0xFF071D41,
  ); // --blue-warm-vivid-90
  static const Color surfaceDarkAlternative = Color(
    0xFF0C326F,
  ); // --blue-warm-vivid-80

  // Função Leitura: cores com contraste adequado sobre superfícies claras/escuras.
  static const Color readingOnLight = Color(0xFF333333); // --gray-80
  static const Color readingOnDark = Color(0xFFFFFFFF); // --pure-0

  // Função Interação: elementos acionáveis, links, seleção e controles.
  static const Color interactionOnLight = Color(
    0xFF1351B4,
  ); // --blue-warm-vivid-70
  static const Color interactionOnDark = Color(0xFFC5D4EB); // --blue-warm-20

  // Função Feedback/Avisos: estados informacionais e validações.
  static const Color info = Color(0xFF155BCB); // --blue-warm-vivid-60
  static const Color infoAlternative = Color(
    0xFFD4E5FF,
  ); // --blue-warm-vivid-10
  static const Color success = Color(0xFF168821); // --green-cool-vivid-50
  static const Color successAlternative = Color(
    0xFFE3F5E1,
  ); // --green-cool-vivid-5
  static const Color warning = Color(0xFFFFCD07); // --yellow-vivid-20
  static const Color warningAlternative = Color(0xFFFFF5C2); // --yellow-vivid-5
  static const Color error = Color(0xFFE52207); // --red-vivid-50
  static const Color errorAlternative = Color(0xFFFDE0DB); // --red-vivid-10

  static const Color borderLight = Color(0xFFE0E0E0);
}
