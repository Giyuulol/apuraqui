import 'package:flutter/material.dart';

import '../../perfil/models/candidate_profile.dart';
import '../models/santinho_item.dart';

class SantinhoCard extends StatefulWidget {
  const SantinhoCard({
    required this.item,
    required this.candidate,
    required this.saved,
    required this.onToggleSave,
    required this.onViewProposals,
    super.key,
  });

  final SantinhoItem item;
  final CandidateProfile candidate;
  final bool saved;
  final Future<void> Function() onToggleSave;
  final VoidCallback onViewProposals;

  @override
  State<SantinhoCard> createState() => _SantinhoCardState();
}

class _SantinhoCardState extends State<SantinhoCard> {
  void _showShareModal() {
    showGeneralDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Fechar modal',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animation, secondaryAnimation) {
        return _SantinhoShareDialog(item: widget.item);
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
          reverseCurve: Curves.easeInCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final accentColor = Color(widget.item.accentColorValue);
    final hasImage = widget.item.imageAsset.trim().isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.10),
            blurRadius: 6,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          children: [
            SizedBox(
              height: 485,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: const Color(0xFFF3F4F6)),
                  if (hasImage)
                    Image.asset(
                      widget.item.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _ImagePlaceholder(
                            candidateName: widget.candidate.nome,
                          ),
                    )
                  else
                    _ImagePlaceholder(candidateName: widget.candidate.nome),
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.35),
                          Color.fromRGBO(0, 0, 0, 0.10),
                          Color.fromRGBO(0, 0, 0, 0.90),
                        ],
                      ),
                    ),
                  ),

                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(0, 0, 0, 0.4),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        widget.candidate.cargo.toUpperCase(),
                        style: textTheme.labelSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 16,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.candidate.nome,
                                style: textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 30,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                widget.candidate.partido,
                                style: textTheme.titleSmall?.copyWith(
                                  color: const Color.fromRGBO(
                                    255,
                                    255,
                                    255,
                                    0.9,
                                  ),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 9,
                            ),
                            decoration: BoxDecoration(
                              color: accentColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              widget.candidate.numero,
                              style: textTheme.displaySmall?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 30,
                                letterSpacing: 3,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeInOut,
                      decoration: BoxDecoration(
                        color: widget.saved
                            ? const Color(0xFFDCFCE7)
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await widget.onToggleSave();
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 220),
                          switchInCurve: Curves.easeOut,
                          switchOutCurve: Curves.easeIn,
                          transitionBuilder: (child, animation) =>
                              FadeTransition(opacity: animation, child: child),
                          child: Row(
                            key: ValueKey(widget.saved),
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                widget.saved
                                    ? Icons.check_circle_outline
                                    : Icons.download_outlined,
                                size: 16,
                                color: widget.saved
                                    ? const Color(0xFF008236)
                                    : const Color(0xFF364153),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.saved
                                    ? 'Santinho salvo!'
                                    : 'Salvar Santinho',
                                style: textTheme.labelLarge?.copyWith(
                                  color: widget.saved
                                      ? const Color(0xFF008236)
                                      : const Color(0xFF364153),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: DecoratedBox(
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
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        onPressed: widget.onViewProposals,
                        icon: const Icon(Icons.library_books_outlined, size: 18),
                        label: Text(
                          'Ver Propostas',
                          style: textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF002776),
                        side: const BorderSide(color: Color(0xFF002776), width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _showShareModal,
                      icon: const Icon(Icons.share_outlined, size: 18),
                      label: Text(
                        'Compartilhar',
                        style: textTheme.labelLarge?.copyWith(
                          color: const Color(0xFF002776),
                          fontWeight: FontWeight.w800,
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

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder({required this.candidateName});

  final String candidateName;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      color: const Color(0xFFE5E7EB),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.image_outlined,
              size: 42,
              color: Color(0xFF6A7282),
            ),
            const SizedBox(height: 12),
            Text(
              candidateName,
              style: textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: const Color(0xFF364153),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Adicione a foto em imageAsset no mock.',
              style: textTheme.bodyMedium?.copyWith(
                color: const Color(0xFF6A7282),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SantinhoShareDialog extends StatelessWidget {
  const _SantinhoShareDialog({required this.item});

  final SantinhoItem item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 407,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
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
                padding: const EdgeInsets.fromLTRB(44, 32, 44, 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xFF009B3A),
                          width: 3,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          item.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const ColoredBox(
                                color: Color(0xFFE8F5E9),
                                child: Icon(
                                  Icons.person_outline,
                                  color: Color(0xFF009B3A),
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Compartilhar\nSantinho',
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
                      'Mostre este QR Code para outra pessoa escanear ou compartilhar com segurança.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF6A7282),
                      ),
                    ),
                    const SizedBox(height: 24),
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
      ),
    );
  }
}
