import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';
import 'data/local_votacao_mock.dart';

class LocalVotacaoPage extends StatefulWidget {
  const LocalVotacaoPage({
    required this.onMenuPressed,
    required this.onLogout,
    super.key,
  });

  final VoidCallback onMenuPressed;
  final VoidCallback onLogout;

  @override
  State<LocalVotacaoPage> createState() => _LocalVotacaoPageState();
}

class _LocalVotacaoPageState extends State<LocalVotacaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  LocalVotacaoDemo? _result;
  QueueStatus? _reportedQueue;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _search() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final digits = _onlyDigits(_controller.text);
    final exact = locaisVotacaoMock.where(
      (local) => local.documentKey == digits,
    );
    setState(() {
      _result = exact.isNotEmpty
          ? exact.first
          : locaisVotacaoMock[digits.codeUnitAt(digits.length - 1) %
                locaisVotacaoMock.length];
      _reportedQueue = null;
    });
  }

  void _reportQueue(QueueStatus status) {
    setState(() => _reportedQueue = status);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Obrigado! Fila atualizada para ${status.label}.'),
      ),
    );
  }

  String _onlyDigits(String value) => value.replaceAll(RegExp(r'\D'), '');

  String? _validateDocument(String? value) {
    final digits = _onlyDigits(value ?? '');
    if (digits.isEmpty) {
      return 'Informe CPF ou título de eleitor.';
    }
    if (digits.length != 11 && digits.length != 12) {
      return 'Digite 11 dígitos para CPF ou 12 para título.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppHeader(
        onMenuPressed: widget.onMenuPressed,
        onLogoutPressed: widget.onLogout,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 32),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(0, 39, 118, 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.location_on_outlined,
                    color: Color(0xFF002776),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Local de Votação',
                        style: textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF111827),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Consulte sua seção e simule a atualização da fila',
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
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFFFEF3C7,
                        ), // bg-amber-50 / yellow tone
                        borderRadius: BorderRadius.circular(12),
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
                              'Digite CPF ou título de eleitor. A consulta usa dados simulados nesta versão acadêmica.',
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
                    const SizedBox(height: 18),
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      inputFormatters: [CpfOuTituloInputFormatter()],
                      decoration: InputDecoration(
                        labelText: 'Documento',
                        hintText: 'Digite CPF ou Título (apenas números)',
                        prefixIcon: const Icon(
                          Icons.badge_outlined,
                          color: Color(0xFF9CA3AF),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(
                          color: Color(0xFF4B5563),
                          fontWeight: FontWeight.w600,
                        ),
                        hintStyle: const TextStyle(color: Color(0xFF9CA3AF)),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFF009B3A),
                            width: 2,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFEF4444),
                            width: 2,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: const BorderSide(
                            color: Color(0xFFEF4444),
                            width: 2,
                          ),
                        ),
                      ),
                      validator: _validateDocument,
                    ),
                    const SizedBox(height: 18),
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF009B3A), Color(0xFF002776)],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF002776,
                            ).withValues(alpha: 0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
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
                        onPressed: _search,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Buscar Local',
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
            ),
            if (_result != null) ...[
              const SizedBox(height: 20),
              _VotingPlaceCard(
                result: _result!,
                queueStatus: _reportedQueue ?? _result!.queueStatus,
                onReportQueue: _reportQueue,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _VotingPlaceCard extends StatelessWidget {
  const _VotingPlaceCard({
    required this.result,
    required this.queueStatus,
    required this.onReportQueue,
  });

  final LocalVotacaoDemo result;
  final QueueStatus queueStatus;
  final ValueChanged<QueueStatus> onReportQueue;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'SITUAÇÃO REGULAR',
                style: textTheme.labelLarge?.copyWith(
                  color: AppColors.success,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            result.schoolName,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            result.address,
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B7280),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _InfoTile(label: 'Zona Eleitoral', value: result.zone),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoTile(label: 'Seção de Voto', value: result.section),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _MockMap(schoolName: result.schoolName),
          const SizedBox(height: 18),
          Text(
            'Monitor de Fila',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF111827),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            queueStatus.description,
            style: textTheme.bodyMedium?.copyWith(
              color: const Color(0xFF4B5563),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              minHeight: 10,
              value: switch (queueStatus) {
                QueueStatus.fast => 0.25,
                QueueStatus.medium => 0.55,
                QueueStatus.slow => 0.88,
              },
              backgroundColor: switch (queueStatus) {
                QueueStatus.fast => const Color(0xFFE3F5E1),
                QueueStatus.medium => const Color(0xFFFFF7D6),
                QueueStatus.slow => const Color(0xFFFDE0DB),
              },
              valueColor: AlwaysStoppedAnimation<Color>(switch (queueStatus) {
                QueueStatus.fast => AppColors.success,
                QueueStatus.medium => const Color(0xFFF5B800),
                QueueStatus.slow => AppColors.error,
              }),
            ),
          ),
          const SizedBox(height: 14),
          Text(
            'Você está no local? Ajude outros eleitores informando como está a fila.',
            style: textTheme.bodySmall?.copyWith(
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _QueueStatusButton(
                  status: QueueStatus.fast,
                  color: const Color(0xFFE3F5E1),
                  textColor: const Color(0xFF168821),
                  isSelected: queueStatus == QueueStatus.fast,
                  onTap: onReportQueue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueStatusButton(
                  status: QueueStatus.medium,
                  color: const Color(0xFFFFF7D6),
                  textColor: const Color(0xFFB7791F),
                  isSelected: queueStatus == QueueStatus.medium,
                  onTap: onReportQueue,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _QueueStatusButton(
                  status: QueueStatus.slow,
                  color: const Color(0xFFFDE0DB),
                  textColor: const Color(0xFFE52207),
                  isSelected: queueStatus == QueueStatus.slow,
                  onTap: onReportQueue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              color: const Color(0xFF6B7280),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: const Color(0xFF002776),
            ),
          ),
        ],
      ),
    );
  }
}

class _QueueStatusButton extends StatelessWidget {
  const _QueueStatusButton({
    required this.status,
    required this.color,
    required this.textColor,
    required this.isSelected,
    required this.onTap,
  });

  final QueueStatus status;
  final Color color;
  final Color textColor;
  final bool isSelected;
  final ValueChanged<QueueStatus> onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isSelected ? 1.04 : 0.96,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: color.withValues(alpha: isSelected ? 1.0 : 0.45),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected ? textColor : Colors.transparent,
            width: isSelected ? 2.5 : 1.0,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: textColor.withValues(alpha: 0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => onTap(status),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected) ...[
                        Icon(
                          Icons.check_circle_rounded,
                          color: textColor,
                          size: 13,
                        ),
                        const SizedBox(width: 4),
                      ],
                      Text(
                        switch (status) {
                          QueueStatus.fast => 'Rápida',
                          QueueStatus.medium => 'Média',
                          QueueStatus.slow => 'Demorada',
                        },
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    status.estimate,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor.withValues(
                        alpha: isSelected ? 0.95 : 0.8,
                      ),
                      fontSize: 10,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MockMap extends StatelessWidget {
  const _MockMap({required this.schoolName});

  final String schoolName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F0E6), // Cor do mapa (verde parque/terra)
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Stack(
          children: [
            // Rio/Água
            Positioned(
              top: -20,
              right: -30,
              child: Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: const Color(0xFFBAE6FD), // Sky-200
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            // Rua 1 (Vertical)
            Positioned(
              left: 80,
              top: 0,
              bottom: 0,
              width: 32,
              child: Container(color: Colors.white),
            ),
            // Rua 2 (Horizontal)
            Positioned(
              left: 0,
              right: 0,
              top: 70,
              height: 32,
              child: Container(color: Colors.white),
            ),
            // Linha tracejada da Rota
            Positioned(
              left: 96,
              top: 0,
              bottom: 86,
              width: 2,
              child: const _DottedLine(),
            ),
            Positioned(
              left: 96,
              right: 130,
              top: 86,
              height: 2,
              child: const _DottedLine(isHorizontal: true),
            ),
            // Outro Bloco / Parque
            Positioned(
              left: 120,
              top: 10,
              child: Container(
                width: 60,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFBBF7D0), // green-200
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            // Quadra / Prédios
            Positioned(
              left: 20,
              top: 115,
              child: Container(
                width: 50,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB), // gray-200
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            Positioned(
              left: 130,
              top: 115,
              child: Container(
                width: 80,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ),
            // Ponto de Interesse (Marcador do local)
            Positioned(
              left: 165,
              top: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Efeito radar piscando / onda
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEF4444).withValues(alpha: 0.4),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Icon(
                    Icons.location_on_rounded,
                    color: Color(0xFFEF4444),
                    size: 28,
                  ),
                ],
              ),
            ),
            // Overlay de identificação da escola
            Positioned(
              left: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.school_rounded,
                      size: 14,
                      color: Color(0xFF002776),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      schoolName.length > 25
                          ? '${schoolName.substring(0, 22)}...'
                          : schoolName,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DottedLine extends StatelessWidget {
  const _DottedLine({this.isHorizontal = false});

  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final length = isHorizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        const dashLength = 4.0;
        const dashSpace = 3.0;
        final count = (length / (dashLength + dashSpace)).floor();
        return Flex(
          direction: isHorizontal ? Axis.horizontal : Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(count, (_) {
            return SizedBox(
              width: isHorizontal ? dashLength : 2,
              height: isHorizontal ? 2 : dashLength,
              child: const DecoratedBox(
                decoration: BoxDecoration(color: Color(0xFF002776)),
              ),
            );
          }),
        );
      },
    );
  }
}

class CpfOuTituloInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    final digits = text.replaceAll(RegExp(r'\D'), '');

    // Limita o número máximo de dígitos a 12
    if (digits.length > 12) {
      return oldValue;
    }

    String formatted = '';
    // Se tiver até 11 dígitos, formata como CPF: 000.000.000-00
    if (digits.length <= 11) {
      for (int i = 0; i < digits.length; i++) {
        if (i == 3 || i == 6) {
          formatted += '.';
        } else if (i == 9) {
          formatted += '-';
        }
        formatted += digits[i];
      }
    }
    // Se tiver 12 dígitos, formata como Título de Eleitor: 0000 0000 0000
    else {
      for (int i = 0; i < digits.length; i++) {
        if (i == 4 || i == 8) {
          formatted += ' ';
        }
        formatted += digits[i];
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
