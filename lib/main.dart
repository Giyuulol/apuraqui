import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/design_system/theme/app_theme.dart';
import 'core/navigation/app_routes.dart';
import 'core/preferences/app_preferences_providers.dart';
import 'core/widgets/app_state_view.dart';
import 'features/auth/application/auth_providers.dart';
import 'features/auth/login_screen.dart';
import 'features/comparador/comparador_propostas_page.dart';
import 'features/dashboard/dashboard_page.dart';
import 'features/dashboard/prototype_menu_drawer.dart';
import 'features/leitor_qr/leitor_qr_page.dart';
import 'features/local_votacao/local_votacao_page.dart';
import 'features/noticias/central_noticias_page.dart';
import 'features/perfil/candidatos_page.dart';
import 'features/santinho/santinhos_page.dart';
import 'features/votacao/checklist_documentos_page.dart';
import 'features/splash/splash_screen.dart';

void main() {
  runApp(const ProviderScope(child: ApuraquiApp()));
}

class ApuraquiApp extends StatelessWidget {
  const ApuraquiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApurAqui',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
      routes: {AppRoutes.comparator: (_) => const ComparadorPropostasPage()},
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(sessionProvider)
        .when(
          data: (session) {
            if (session == null) return const LoginScreen();
            return const AppHomePage();
          },
          error: (error, stackTrace) => AppStateView.serverError(
            onRetry: () => ref.invalidate(sessionProvider),
          ),
          loading: () =>
              const Scaffold(body: Center(child: CircularProgressIndicator())),
        );
  }
}

class AppHomePage extends ConsumerStatefulWidget {
  const AppHomePage({super.key});

  @override
  ConsumerState<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends ConsumerState<AppHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _selectDestination(int index) {
    ref.read(appPreferencesRepositoryProvider).saveNavigationIndex(index);
    Navigator.of(context).pop();
  }

  Future<void> _confirmLogout() async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sair da Conta?'),
        content: const Text(
          'Você precisará fazer login novamente para acessar os dados da apuração.',
        ),
        actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        actions: [
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFE10600),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                ref.read(authControllerProvider.notifier).logout();
              },
              child: const Text('Sim, quero sair'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationIndexProvider).value ?? 0;

    final pages = <Widget>[
      DashboardPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      SantinhosPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      ComparadorPropostasPage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
      ),
      LocalVotacaoPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      LeitorQrCodePage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      ChecklistDocumentosPage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
      ),
      CandidatosPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      CentralNoticiasPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
    ];

    return Scaffold(
      key: _scaffoldKey,
      drawer: PrototypeMenuDrawer(
        selectedIndex: currentIndex,
        onDestinationSelected: _selectDestination,
        onLogoutPressed: _confirmLogout,
      ),
      body: IndexedStack(index: currentIndex, children: pages),
    );
  }
}
