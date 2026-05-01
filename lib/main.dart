import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/noticias/central_noticias_page.dart';
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
      home: const AppHomePage(),
    );
  }
}

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int _currentIndex = 0;

  static const _pages = <Widget>[
    ChecklistDocumentosPage(),
    CentralNoticiasPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) => setState(() => _currentIndex = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.checklist_outlined),
            selectedIcon: Icon(Icons.checklist),
            label: 'Checklist',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper),
            label: 'Notícias',
          ),
        ],
      ),
    );
  }
}
