import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/design_system/theme/app_theme.dart';
import 'core/navigation/app_routes.dart';
import 'core/preferences/app_preferences_providers.dart';
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
import 'features/splash/splash_screen.dart';
import 'features/votacao/checklist_documentos_page.dart';

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
      routes: {
        AppRoutes.comparator: (_) => const ComparadorPropostasPage(),
        AppRoutes.candidateProfile: (ctx) {
          final id = ModalRoute.of(ctx)?.settings.arguments as String?;
          return CandidatosPage(initialCandidateId: id);
        },
      },
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
          error: (error, stackTrace) {
            debugPrint('ERRO SESSION PROVIDER: $error');
            debugPrint(stackTrace.toString());

            return Scaffold(
              body: Center(child: SelectableText('Erro:\n$error')),
            );
          },
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
  static const _comparatorIndex = 2;
  static const _profileIndex = 6;

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void _selectDestination(int index) {
    ref.read(appPreferencesRepositoryProvider).saveNavigationIndex(index).then((
      _,
    ) {
      if (!mounted) return;
      Navigator.of(context).pop();
    });
  }

  void _showDestination(int index) {
    ref.read(appPreferencesRepositoryProvider).saveNavigationIndex(index);
  }

  /// Navega para a aba de Perfil pré-selecionando o candidato pelo ID.
  void _showCandidateProfile(String candidateId) {
    // Persiste o selectedCandidateId antes de mudar a aba
    ref
        .read(appPreferencesRepositoryProvider)
        .saveNavigationIndex(_profileIndex);
    // A CandidatosPage usa initialCandidateId apenas no initState;
    // usamos uma Key dinâmica para forçar recriação com o novo candidato.
    setState(() {
      _pendingCandidateId = candidateId;
    });
  }

  String? _pendingCandidateId;

  Future<void> _confirmLogout() async {
    final textTheme = Theme.of(context).textTheme;
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32), // rounded-[2rem]
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Ícone de Logout circular
              Container(
                width: 76,
                height: 76,
                decoration: const BoxDecoration(
                  color: Color(0xFFFEF2F2), // bg-red-50
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xFFEF4444), // text-red-500
                  size: 36,
                ),
              ),
              const SizedBox(height: 20),
              // Título
              Text(
                'Sair do ApurAqui?',
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                  color: const Color(0xFF111827),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Descrição
              Text(
                'Tem certeza que deseja sair do aplicativo? Você precisará fazer login novamente.',
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF6B7280),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),
              // Botões empilhados verticalmente
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFDC2626).withValues(alpha: 0.2),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFDC2626), // bg-red-600
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        ref.read(authControllerProvider.notifier).logout();
                      },
                      child: Text(
                        'Sim, quero sair',
                        style: textTheme.labelLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF3F4F6), // bg-gray-100
                        foregroundColor: const Color(
                          0xFF374151,
                        ), // text-gray-700
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Cancelar',
                        style: textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF374151),
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(navigationIndexProvider).value ?? 0;

    final pages = <Widget>[
      DashboardPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      SantinhosPage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
        onViewProposals: (candidateId) => _showCandidateProfile(candidateId),
      ),
      ComparadorPropostasPage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
      ),
      LocalVotacaoPage(onMenuPressed: _openDrawer, onLogout: _confirmLogout),
      LeitorQrCodePage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
        onViewProposals: (candidateId) => _showCandidateProfile(candidateId),
      ),
      ChecklistDocumentosPage(
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
      ),
      CandidatosPage(
        key: ValueKey(_pendingCandidateId),
        onMenuPressed: _openDrawer,
        onLogout: _confirmLogout,
        onViewProposals: (candidateId) => _showDestination(_comparatorIndex),
        initialCandidateId: _pendingCandidateId,
      ),
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
