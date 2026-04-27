import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class AppInfoAlert extends StatelessWidget {
  const AppInfoAlert({
    required this.message,
    this.boldText,
    this.icon = Icons.info_outline,
    super.key,
  });

  final String message;
  final String? boldText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Semantics(
      container: true,
      label: message,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.infoAlternative,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.info, size: 24),
              const SizedBox(width: 12),
              Expanded(
                child: Text.rich(
                  _buildMessageSpan(
                    baseStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColors.info,
                      height: 1.35,
                    ),
                    boldStyle: textTheme.bodyMedium?.copyWith(
                      color: AppColors.info,
                      fontWeight: FontWeight.w700,
                      height: 1.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextSpan _buildMessageSpan({
    required TextStyle? baseStyle,
    required TextStyle? boldStyle,
  }) {
    final highlightedText = boldText;

    if (highlightedText == null || !message.contains(highlightedText)) {
      return TextSpan(text: message, style: baseStyle);
    }

    final parts = message.split(highlightedText);

    return TextSpan(
      style: baseStyle,
      children: [
        TextSpan(text: parts.first),
        TextSpan(text: highlightedText, style: boldStyle),
        TextSpan(text: parts.skip(1).join(highlightedText)),
      ],
    );
  }
}
