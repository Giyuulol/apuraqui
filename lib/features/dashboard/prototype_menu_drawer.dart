import 'package:flutter/material.dart';

import '../../core/design_system/tokens/app_colors.dart';

class PrototypeMenuDrawer extends StatelessWidget {
  const PrototypeMenuDrawer({
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.onLogoutPressed,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final VoidCallback onLogoutPressed;

  static const _items = <_DrawerItem>[
    _DrawerItem('Dashboard (Ao Vivo)', Icons.space_dashboard_outlined),
    _DrawerItem('Santinhos Digitais', Icons.style_outlined),
    _DrawerItem('Comparador de Propostas', Icons.balance_outlined),
    _DrawerItem('Local de Votação', Icons.location_on_outlined),
    _DrawerItem('Leitor de QR Code', Icons.qr_code_scanner_outlined),
    _DrawerItem('Checklist de Votação', Icons.checklist_outlined),
    _DrawerItem('Perfis dos Candidatos', Icons.groups_outlined),
    _DrawerItem('Central de Notícias', Icons.newspaper_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(12, 8, 12, 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF12A150), Color(0xFF0B4B9A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.how_to_vote_outlined,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ApurAqui',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sistema de apuração em tempo real',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 6),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final isSelected = index == selectedIndex;

                  return ListTile(
                    selected: isSelected,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.success
                            : Colors.transparent,
                      ),
                    ),
                    selectedTileColor: AppColors.successAlternative,
                    leading: Icon(
                      item.icon,
                      color: isSelected
                          ? AppColors.success
                          : AppColors.readingOnLight.withValues(alpha: 0.7),
                    ),
                    title: Text(
                      item.label,
                      style: TextStyle(
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: isSelected
                            ? AppColors.success
                            : AppColors.readingOnLight,
                      ),
                    ),
                    onTap: () => onDestinationSelected(index),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onLogoutPressed();
                  },
                  icon: const Icon(Icons.logout, color: Color(0xFFE10600)),
                  label: const Text(
                    'Sair da Aplicação',
                    style: TextStyle(color: Color(0xFFE10600)),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFF3D0D0)),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem {
  const _DrawerItem(this.label, this.icon);

  final String label;
  final IconData icon;
}
