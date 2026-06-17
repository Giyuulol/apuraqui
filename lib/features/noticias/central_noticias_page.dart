import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/design_system/components/app_card.dart';
import '../../core/design_system/tokens/app_colors.dart';
import '../../core/widgets/app_header.dart';
import 'data/noticias_mock.dart';
import 'widgets/fake_news_check_card.dart';
import 'widgets/news_card.dart';

class CentralNoticiasPage extends StatelessWidget {
  const CentralNoticiasPage({this.onMenuPressed, this.onLogout, super.key});

  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogout;

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/news_section_badge.svg',
                  width: 48,
                  height: 48,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Notícias e Verificação',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SizedBox(
                        width: 24,
                        child: Icon(
                          Icons.check_circle_outline,
                          color: AppColors.success,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Jornais com Credibilidade',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Filtre as notícias eleitorais apenas por veículos confiáveis.',
                    style: textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 14),
                  for (var i = 0; i < newsItemsMock.length; i++) ...[
                    NewsCard(item: newsItemsMock[i]),
                    if (i != newsItemsMock.length - 1)
                      const SizedBox(height: 10),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.errorAlternative.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.errorAlternative),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const SizedBox(
                          width: 24,
                          child: Icon(
                            Icons.verified_user_outlined,
                            color: AppColors.error,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Central Anti-Fake News',
                            style: textTheme.titleMedium?.copyWith(
                              color: const Color(0xFF7A1E1E),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Boatos e desinformações verificadas por agências de checagem.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 14),
                    for (var i = 0; i < fakeNewsItemsMock.length; i++) ...[
                      FakeNewsCheckCard(item: fakeNewsItemsMock[i]),
                      if (i != fakeNewsItemsMock.length - 1)
                        const SizedBox(height: 10),
                    ],
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
