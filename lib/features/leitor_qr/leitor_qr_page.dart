import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/navigation/app_routes.dart';
import '../../core/widgets/app_header.dart';
import '../perfil/data/candidates_mock.dart';
import '../santinho/application/saved_santinhos_providers.dart';
import '../santinho/data/santinhos_mock.dart';

class LeitorQrCodePage extends ConsumerWidget {
  const LeitorQrCodePage({
    required this.onMenuPressed,
    required this.onLogout,
    this.onViewProposals,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;
  final void Function(String candidateId)? onViewProposals;

  void _showDemoResult(BuildContext context, WidgetRef ref) {
    final santinho = santinhosMock.first;
    final candidate = candidatesMock.firstWhere(
      (candidate) => candidate.id == santinho.candidateId,
    );

    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final savedIds = ref.watch(savedSantinhoIdsProvider).value ?? {};
            final isSaved = savedIds.contains(santinho.id);
            final textTheme = Theme.of(context).textTheme;

            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resultado simulado do QR Code',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppCard(
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(2.5),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xFF009B3A),
                                    Color(0xFF002776),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(1.5),
                                child: ClipOval(
                                  child: Image.asset(
                                    candidate.foto,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(
                                              Icons.person_outline,
                                              size: 28,
                                              color: Color(0xFF002776),
                                            ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    candidate.nome,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      color: const Color(0xFF111827),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    '${candidate.partido} • ${candidate.cargo}',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF6B7280),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF002776),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                candidate.numero,
                                style: textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botão Salvar/Remover (Toggle) com design premium
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        height: 52,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: isSaved
                              ? null
                              : const LinearGradient(
                                  colors: [
                                    Color(0xFF009B3A),
                                    Color(0xFF002776),
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                          color: isSaved ? const Color(0xFFDCFCE7) : null,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: isSaved
                              ? null
                              : const [
                                  BoxShadow(
                                    color: Color.fromRGBO(0, 39, 118, 0.26),
                                    blurRadius: 18,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: isSaved
                                ? const Color(0xFF008236)
                                : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          onPressed: () async {
                            await ref
                                .read(savedSantinhosRepositoryProvider)
                                .setSaved(santinho.id, saved: !isSaved);
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  isSaved
                                      ? 'Santinho removido da sua lista.'
                                      : 'Santinho salvo na sua lista.',
                                ),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                isSaved
                                    ? Icons.check_circle_outline_rounded
                                    : Icons.download_rounded,
                                size: 20,
                                color: isSaved
                                    ? const Color(0xFF008236)
                                    : Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isSaved ? 'Santinho salvo!' : 'Salvar santinho',
                                style: textTheme.labelLarge?.copyWith(
                                  color: isSaved
                                      ? const Color(0xFF008236)
                                      : Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Color(0xFF002776),
                              width: 2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                            foregroundColor: const Color(0xFF002776),
                          ),
                           onPressed: () {
                            Navigator.of(context).pop();
                            final callback = onViewProposals;
                            if (callback != null) {
                              callback(candidate.id);
                              return;
                            }
                            Navigator.of(
                              context,
                            ).pushNamed(
                              AppRoutes.candidateProfile,
                              arguments: candidate.id,
                            );
                          },
                          icon: const Icon(
                            Icons.library_books_outlined,
                            size: 20,
                          ),
                          label: Text(
                            'Ver propostas',
                            style: textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF002776),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 155, 58, 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: Color(0xFF009B3A),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Leitor de Santinhos',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Escaneamento simulado para a entrega acadêmica',
                        style: textTheme.bodyMedium?.copyWith(
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppCard(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7), // tom âmbar
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFFDE68A)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline_rounded,
                          color: Color(0xFFD97706),
                          size: 18,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'A câmera real fica fora do escopo desta fase. Toque para simular a leitura de um santinho e testar o fluxo completo.',
                            style: textTheme.bodySmall?.copyWith(
                              color: const Color(0xFF92400E),
                              fontWeight: FontWeight.w500,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  const _CameraScannerPreview(),
                  const SizedBox(height: 24),
                  Container(
                    height: 52,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF009B3A), Color(0xFF002776)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(0, 39, 118, 0.26),
                          blurRadius: 18,
                          offset: Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: () => _showDemoResult(context, ref),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.qr_code_scanner_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Tocar para Escanear',
                            style: textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                            ),
                          ),
                        ],
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

class _CameraScannerPreview extends StatefulWidget {
  const _CameraScannerPreview();

  @override
  State<_CameraScannerPreview> createState() => _CameraScannerPreviewState();
}

class _CameraScannerPreviewState extends State<_CameraScannerPreview>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    if (!Platform.environment.containsKey('FLUTTER_TEST')) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: Stack(
          children: [
            const Center(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white24,
                size: 52,
              ),
            ),
            // Cantos de mira estilizados (Viewfinder)
            const Positioned.fill(
              child: Padding(
                padding: EdgeInsets.all(28.0),
                child: _ViewfinderCorners(
                  color: Color(0xFFFFDF00), // Amarelo Urna
                  strokeWidth: 3.0,
                  cornerLength: 18,
                ),
              ),
            ),
            // Linha laser de varredura animada
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                // Fazer a linha ir de 34.0 a 162.0 (dentro do viewfinder de 144x144)
                final position = 34.0 + (_controller.value * 128.0);
                return Positioned(
                  top: position,
                  left: 36,
                  right: 36,
                  child: Container(
                    height: 2.5,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDF00),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(
                            0xFFFFDF00,
                          ).withValues(alpha: 0.75),
                          blurRadius: 6,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewfinderCorners extends StatelessWidget {
  const _ViewfinderCorners({
    required this.color,
    required this.strokeWidth,
    required this.cornerLength,
  });

  final Color color;
  final double strokeWidth;
  final double cornerLength;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ViewfinderCornersPainter(
        color: color,
        strokeWidth: strokeWidth,
        cornerLength: cornerLength,
      ),
    );
  }
}

class _ViewfinderCornersPainter extends CustomPainter {
  _ViewfinderCornersPainter({
    required this.color,
    required this.strokeWidth,
    required this.cornerLength,
  });

  final Color color;
  final double strokeWidth;
  final double cornerLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final width = size.width;
    final height = size.height;

    // Canto Superior Esquerdo
    canvas.drawPath(
      Path()
        ..moveTo(0, cornerLength)
        ..lineTo(0, 0)
        ..lineTo(cornerLength, 0),
      paint,
    );

    // Canto Superior Direito
    canvas.drawPath(
      Path()
        ..moveTo(width - cornerLength, 0)
        ..lineTo(width, 0)
        ..lineTo(width, cornerLength),
      paint,
    );

    // Canto Inferior Esquerdo
    canvas.drawPath(
      Path()
        ..moveTo(0, height - cornerLength)
        ..lineTo(0, height)
        ..lineTo(cornerLength, height),
      paint,
    );

    // Canto Inferior Direito
    canvas.drawPath(
      Path()
        ..moveTo(width - cornerLength, height)
        ..lineTo(width, height)
        ..lineTo(width, height - cornerLength),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
