import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../design_system/tokens/app_colors.dart';
import '../design_system/tokens/app_radius.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({this.onMenuPressed, super.key});

  final VoidCallback? onMenuPressed;

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      backgroundColor: AppColors.surfaceLightPrimary,
      surfaceTintColor: AppColors.surfaceLightPrimary,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.10),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: AppColors.borderLight),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            if (onMenuPressed != null) ...[
              IconButton(
                onPressed: onMenuPressed,
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.interactionOnLight,
                ),
                visualDensity: VisualDensity.compact,
                tooltip: 'Menu',
              ),
              const SizedBox(width: 6),
            ],
            SvgPicture.asset(
              'assets/icons/apuraqui_logo.svg',
              width: 109,
              height: 28,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.errorAlternative,
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.errorAlternative),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.46),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AO VIVO',
                    style: textTheme.labelSmall?.copyWith(
                      color: AppColors.error,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.6,
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
