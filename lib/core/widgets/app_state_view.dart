import 'package:flutter/material.dart';

import '../design_system/tokens/app_colors.dart';
import '../design_system/tokens/app_spacing.dart';

enum AppStateViewKind { offline, serverError, empty }

class AppStateView extends StatelessWidget {
  const AppStateView.offline({required VoidCallback this.onRetry, super.key})
    : kind = AppStateViewKind.offline,
      message = 'Verifique sua internet e tente novamente.';

  const AppStateView.serverError({
    required VoidCallback this.onRetry,
    super.key,
  }) : kind = AppStateViewKind.serverError,
       message =
           'Não conseguimos acessar o sistema.\nTente novamente em instantes.';

  const AppStateView.empty({
    this.message = 'Nenhum resultado encontrado.',
    super.key,
  }) : kind = AppStateViewKind.empty,
       onRetry = null;

  final AppStateViewKind kind;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final showRetry = onRetry != null;

    return Scaffold(
      backgroundColor: AppColors.surfaceLightPrimary,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_icon, size: 90, color: _iconColor),
              const SizedBox(height: AppSpacing.lg),
              Text(
                _title,
                textAlign: TextAlign.center,
                style: textTheme.headlineSmall,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: textTheme.bodyMedium,
              ),
              if (showRetry) ...[
                const SizedBox(height: AppSpacing.xl),
                FilledButton.icon(
                  onPressed: onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Tentar novamente'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String get _title => switch (kind) {
    AppStateViewKind.offline => 'Sem conexão',
    AppStateViewKind.serverError => 'Algo deu errado',
    AppStateViewKind.empty => 'Lista vazia',
  };

  IconData get _icon => switch (kind) {
    AppStateViewKind.offline => Icons.wifi_off_rounded,
    AppStateViewKind.serverError => Icons.error_outline_rounded,
    AppStateViewKind.empty => Icons.search_off_rounded,
  };

  Color get _iconColor => switch (kind) {
    AppStateViewKind.offline => AppColors.info,
    AppStateViewKind.serverError => AppColors.error,
    AppStateViewKind.empty => AppColors.readingOnLight,
  };
}
