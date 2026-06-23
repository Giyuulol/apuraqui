import 'package:flutter/material.dart';

import '../design_system/tokens/app_colors.dart';
import '../design_system/tokens/app_spacing.dart';

enum AppStateViewKind { loading, offline, serverError, empty }

class AppStateView extends StatelessWidget {
  const AppStateView.loading({
    this.message = 'Carregando informações...',
    this.compact = false,
    super.key,
  }) : kind = AppStateViewKind.loading,
       onRetry = null;

  const AppStateView.offline({required VoidCallback this.onRetry, super.key})
    : kind = AppStateViewKind.offline,
      message = 'Verifique sua internet e tente novamente.',
      compact = false;

  const AppStateView.offlineCompact({
    required VoidCallback this.onRetry,
    this.message = 'Verifique sua internet e tente novamente.',
    super.key,
  }) : kind = AppStateViewKind.offline,
       compact = true;

  const AppStateView.serverError({
    required VoidCallback this.onRetry,
    super.key,
  }) : kind = AppStateViewKind.serverError,
       message =
           'Não conseguimos acessar o sistema.\nTente novamente em instantes.',
       compact = false;

  const AppStateView.serverErrorCompact({
    required VoidCallback this.onRetry,
    this.message = 'Não foi possível atualizar estas informações.',
    super.key,
  }) : kind = AppStateViewKind.serverError,
       compact = true;

  const AppStateView.empty({
    this.message = 'Nenhum resultado encontrado.',
    this.compact = false,
    super.key,
  }) : kind = AppStateViewKind.empty,
       onRetry = null;

  final AppStateViewKind kind;
  final String message;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final showRetry = onRetry != null;

    if (compact) return _buildCompact(context, textTheme, showRetry);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Semantics(
          container: true,
          liveRegion: true,
          label: '$_title. $message',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _leadingIcon(size: 90),
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

  Widget _buildCompact(
    BuildContext context,
    TextTheme textTheme,
    bool showRetry,
  ) {
    if (kind == AppStateViewKind.loading) {
      return Semantics(
        liveRegion: true,
        label: message,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(message, style: textTheme.bodySmall),
            ],
          ),
        ),
      );
    }

    return Semantics(
      container: true,
      liveRegion: true,
      label: '$_title. $message',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: _backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _iconColor.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _leadingIcon(size: 22),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _title,
                    style: textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(message, style: textTheme.bodySmall),
                  if (showRetry) ...[
                    const SizedBox(height: AppSpacing.sm),
                    TextButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Tentar novamente'),
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

  Widget _leadingIcon({required double size}) {
    if (kind == AppStateViewKind.loading) {
      return SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(strokeWidth: size > 40 ? 3 : 2),
      );
    }
    return Icon(_icon, size: size, color: _iconColor);
  }

  String get _title => switch (kind) {
    AppStateViewKind.loading => 'Carregando',
    AppStateViewKind.offline => 'Sem conexão',
    AppStateViewKind.serverError => 'Algo deu errado',
    AppStateViewKind.empty => 'Lista vazia',
  };

  IconData get _icon => switch (kind) {
    AppStateViewKind.loading => Icons.hourglass_top_rounded,
    AppStateViewKind.offline => Icons.wifi_off_rounded,
    AppStateViewKind.serverError => Icons.error_outline_rounded,
    AppStateViewKind.empty => Icons.search_off_rounded,
  };

  Color get _iconColor => switch (kind) {
    AppStateViewKind.loading => AppColors.interactionOnLight,
    AppStateViewKind.offline => AppColors.info,
    AppStateViewKind.serverError => AppColors.error,
    AppStateViewKind.empty => AppColors.readingOnLight,
  };

  Color get _backgroundColor => switch (kind) {
    AppStateViewKind.offline => AppColors.infoAlternative,
    AppStateViewKind.serverError => AppColors.errorAlternative,
    AppStateViewKind.empty => AppColors.surfaceLightAlternative,
    AppStateViewKind.loading => AppColors.surfaceLightAlternative,
  };
}
