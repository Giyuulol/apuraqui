import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 65,
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 0,
      shadowColor: Colors.black.withValues(alpha: 0.10),
      shape: const RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: AppColors.interactionOnLight),
              visualDensity: VisualDensity.compact,
              tooltip: 'Menu',
            ),
            const SizedBox(width: 6),
            SvgPicture.asset(
              'assets/icons/apuraqui_logo.svg',
              width: 109,
              height: 28,
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: const Color(0xFFFFE2E2)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFB2C36).withValues(alpha: 0.46),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'AO VIVO',
                    style: textTheme.labelSmall?.copyWith(
                      color: const Color(0xFFE7000B),
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
