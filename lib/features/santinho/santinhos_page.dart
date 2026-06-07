import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/navigation/app_routes.dart';
import '../../core/widgets/app_header.dart';
import '../perfil/data/candidates_mock.dart';
import 'application/saved_santinhos_providers.dart';
import 'data/santinhos_mock.dart';
import 'widgets/santinho_card.dart';

class SantinhosPage extends ConsumerWidget {
  const SantinhosPage({
    this.onMenuPressed,
    this.onLogout,
    this.onViewProposals,
    super.key,
  });

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;
  final VoidCallback? onViewProposals;

  void _showShareAllModal(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => const _ShareAllDialog(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    final savedIds = ref.watch(savedSantinhoIdsProvider).value ?? {};

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 32),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(255, 223, 0, 0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.domain_verification_outlined,
                    color: Color(0xFFB39E00),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Santinhos Digitais',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Sua cola eleitoral na palma da mão',
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6A7282),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 48,
              child: FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(0, 155, 58, 0.1),
                  foregroundColor: const Color(0xFF007A2D),
                  elevation: 0,
                ),
                onPressed: () => _showShareAllModal(context),
                icon: const Icon(Icons.share_outlined, size: 18),
                label: const Text('Compartilhar Todos'),
              ),
            ),
            const SizedBox(height: 24),
            for (var i = 0; i < santinhosMock.length; i++) ...[
              SantinhoCard(
                item: santinhosMock[i],
                candidate: candidatesMock.firstWhere(
                  (candidate) => candidate.id == santinhosMock[i].candidateId,
                ),
                saved: savedIds.contains(santinhosMock[i].id),
                onToggleSave: () {
                  final isSaved = savedIds.contains(santinhosMock[i].id);
                  return ref
                      .read(savedSantinhosRepositoryProvider)
                      .setSaved(santinhosMock[i].id, saved: !isSaved);
                },
                onViewProposals: () {
                  final callback = onViewProposals;
                  if (callback != null) {
                    callback();
                    return;
                  }
                  Navigator.of(context).pushNamed(AppRoutes.comparator);
                },
              ),
              if (i != santinhosMock.length - 1) const SizedBox(height: 24),
            ],
          ],
        ),
      ),
    );
  }
}

class _ShareAllDialog extends StatelessWidget {
  const _ShareAllDialog();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 407),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.25),
              blurRadius: 50,
              offset: Offset(0, 25),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned(
              left: -128,
              top: -128,
              child: Container(
                width: 256,
                height: 256,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(0, 155, 58, 0.10),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 32, 32, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFF009B3A),
                        width: 3,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xFFE8F5E9),
                      child: Icon(
                        Icons.groups_2_outlined,
                        color: Color(0xFF009B3A),
                        size: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Compartilhar\nTodos',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      height: 1.25,
                      color: const Color(0xFF101828),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Mostre este QR Code para outra pessoa escanear ou envie o link diretamente.',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF6A7282),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 212,
                    height: 212,
                    padding: const EdgeInsets.all(26),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAFB),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 1.2,
                        ),
                      ),
                      child: const Icon(
                        Icons.qr_code_2_rounded,
                        size: 120,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xFFF9FAFB),
                        foregroundColor: const Color(0xFF6A7282),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(
                        'Fechar',
                        style: textTheme.titleSmall?.copyWith(
                          color: const Color(0xFF6A7282),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
