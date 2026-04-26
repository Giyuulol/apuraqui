import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/votacao/checklist_documentos_page.dart';

void main() {
  runApp(const ApuraquiApp());
}

class ApuraquiApp extends StatelessWidget {
  const ApuraquiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApuraAqui',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const ChecklistDocumentosPage(),
    );
  }
}
