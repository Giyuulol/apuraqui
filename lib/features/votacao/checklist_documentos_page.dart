import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/app_header.dart';
import '../auth/application/auth_providers.dart';
import 'application/checklist_progress_providers.dart';
import 'data/checklist_documentos_mock.dart';
import 'widgets/checklist_documento_tile.dart';

class ChecklistDocumentosPage extends ConsumerStatefulWidget {
  const ChecklistDocumentosPage({this.onMenuPressed, this.onLogout, super.key});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;

  @override
  ConsumerState<ChecklistDocumentosPage> createState() =>
      _ChecklistDocumentosPageState();
}

class _ChecklistDocumentosPageState
    extends ConsumerState<ChecklistDocumentosPage> {
  bool _isGenerating = false;
  bool _isGenerated = false;
  Timer? _resetTimer;

  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }

  void _handleGeneratePdf() {
    if (_isGenerated) return;
    setState(() {
      _isGenerating = true;
    });

    _resetTimer?.cancel();
    _resetTimer = Timer(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        _isGenerating = false;
        _isGenerated = true;
      });

      _resetTimer = Timer(const Duration(seconds: 5), () {
        if (!mounted) return;
        setState(() {
          _isGenerated = false;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // Obter sessão para identificar se é candidato
    final session = ref.watch(sessionProvider).value;
    final isCandidato = session?.login == 'candidato@apuraqui.app';

    final items = isCandidato
        ? candidateChecklistMock
        : checklistDocumentosMock;
    final documentosMarcados =
        ref.watch(checkedDocumentIdsProvider).value ?? {};

    final completedCount = items
        .where((item) => documentosMarcados.contains(item.id))
        .length;
    final totalCount = items.length;
    final progressFraction = totalCount > 0 ? completedCount / totalCount : 0.0;
    final progressPercentage = (progressFraction * 100).round();

    final themeColor = isCandidato
        ? const Color(0xFF002776)
        : const Color(0xFF009B3A);

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          children: [
            // Header Context
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: themeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    isCandidato
                        ? Icons.workspace_premium_rounded
                        : Icons.fact_check_rounded,
                    color: themeColor,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isCandidato
                            ? 'Checklist de Campanha'
                            : 'Checklist do Eleitor',
                        style: textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Prepare-se para o dia da eleição',
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

            // Important Alert
            if (!isCandidato)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF7ED),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFEDD4)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFEDD4),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.warning_amber_rounded,
                        size: 20,
                        color: Color(0xFFF54900),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atenção com o celular!',
                            style: textTheme.titleSmall?.copyWith(
                              color: const Color(0xFF9F2D00),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text.rich(
                            TextSpan(
                              text:
                                  'O uso de telefone celular, máquina fotográfica ou filmadora é ',
                              style: textTheme.bodyMedium?.copyWith(
                                color: const Color(0xFFCA3500),
                                height: 1.45,
                              ),
                              children: const [
                                TextSpan(
                                  text: 'rigorosamente proibido',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      ' dentro da cabine de votação. Deixe os equipamentos com o mesário antes de votar.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFDBEAFE)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: Color(0xFFDBEAFE),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.info_outline_rounded,
                        size: 20,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Organize sua campanha!',
                            style: textTheme.titleSmall?.copyWith(
                              color: const Color(0xFF1E3A8A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Use este checklist para garantir que todos os aspectos da sua campanha estão em ordem. Marque cada item conforme for concluindo.',
                            style: textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF1D4ED8),
                              height: 1.45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),

            // Checklist Items
            ...items.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ChecklistDocumentoTile(
                  documento: item,
                  checked: documentosMarcados.contains(item.id),
                  isCandidato: isCandidato,
                  onChanged: (marcado) {
                    ref
                        .read(checklistProgressRepositoryProvider)
                        .setChecked(item.id, checked: marcado);
                  },
                ),
              );
            }),
            const SizedBox(height: 16),

            // Action Footer - Eleitor
            if (!isCandidato)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.print_outlined,
                        color: Color(0xFF002776),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Precisa de uma colinha?',
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Gere um PDF com os números dos seus candidatos favoritos já preenchidos, pronto para imprimir e levar no dia.',
                      textAlign: TextAlign.center,
                      style: textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFF6B7280),
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      height: 52,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: _isGenerating
                              ? [
                                  const Color(
                                    0xFF009B3A,
                                  ).withValues(alpha: 0.6),
                                  const Color(
                                    0xFF002776,
                                  ).withValues(alpha: 0.6),
                                ]
                              : _isGenerated
                              ? const [Color(0xFF009B3A), Color(0xFF168821)]
                              : const [Color(0xFF009B3A), Color(0xFF002776)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: _isGenerated
                                ? const Color(
                                    0xFF168821,
                                  ).withValues(alpha: 0.22)
                                : const Color(
                                    0xFF002776,
                                  ).withValues(alpha: 0.26),
                            blurRadius: 18,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.white,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        onPressed: _isGenerating || _isGenerated
                            ? null
                            : _handleGeneratePdf,
                        icon: _isGenerating
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.2,
                                  color: Colors.white,
                                ),
                              )
                            : Icon(
                                _isGenerated
                                    ? Icons.check_circle
                                    : Icons.download_outlined,
                                size: 20,
                                color: Colors.white,
                              ),
                        label: Text(
                          _isGenerating
                              ? 'Preparando arquivo...'
                              : _isGenerated
                              ? 'Colinha Pronta! Verifique os downloads'
                              : 'Gerar Colinha em PDF',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Candidate Progress Footer
            if (isCandidato)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF002776).withValues(alpha: 0.1),
                      const Color(0xFF0039A6).withValues(alpha: 0.1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF002776).withValues(alpha: 0.2),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Progresso da Campanha',
                                style: textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xFF111827),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '$completedCount de $totalCount itens concluídos',
                                style: textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF4B5563),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            color: Color(0xFF002776),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$progressPercentage%',
                            style: textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: LinearProgressIndicator(
                        minHeight: 10,
                        value: progressFraction,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF002776),
                        ),
                      ),
                    ),
                    if (completedCount == totalCount) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFFDBEAFE),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              color: Color(0xFF1D4ED8),
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Parabéns!',
                                    style: textTheme.titleSmall?.copyWith(
                                      color: const Color(0xFF1E3A8A),
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Sua campanha está totalmente organizada!',
                                    style: textTheme.bodySmall?.copyWith(
                                      color: const Color(0xFF1D4ED8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
