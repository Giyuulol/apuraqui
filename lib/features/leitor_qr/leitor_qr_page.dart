import 'package:flutter/material.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';

class LeitorQrCodePage extends StatelessWidget {
  const LeitorQrCodePage({
    required this.onMenuPressed,
    required this.onLogout,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: onMenuPressed,
        onLogoutPressed: onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: AppColors.successAlternative,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    color: AppColors.success,
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
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Escaneie o QR Code do material de campanha',
                        style: textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF8D8),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      'Aponte a câmera para o QR Code impresso no santinho para adicionar o candidato à sua lista ou ver propostas.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      border: Border.all(color: const Color(0xFFE7E7E7)),
                    ),
                    child: const Stack(
                      children: [
                        Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Colors.white54,
                            size: 48,
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 120,
                            height: 120,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border.fromBorderSide(
                                  BorderSide(
                                    color: Color(0xFFFFD600),
                                    width: 2,
                                  ),
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Tocar para Escanear'),
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
