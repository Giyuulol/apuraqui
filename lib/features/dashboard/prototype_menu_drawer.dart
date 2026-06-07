import 'package:flutter/material.dart';

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
    _DrawerItem('Dashboard (Demo)', Icons.home_outlined),
    _DrawerItem('Santinhos Digitais', Icons.how_to_vote_outlined),
    _DrawerItem('Comparador de Propostas', Icons.balance_outlined),
    _DrawerItem('Local de Votação', Icons.location_on_outlined),
    _DrawerItem('Leitor de QR Code', Icons.qr_code_outlined),
    _DrawerItem('Checklist de Votação', Icons.check_box_outlined),
    _DrawerItem('Perfis dos Candidatos', Icons.people_alt_outlined),
    _DrawerItem('Central de Notícias', Icons.newspaper_outlined),
    _DrawerItem('Exceções e Inelegibilidade', Icons.gavel_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            // Header Context with Gradient
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF009B3A),
                    Color(0xFF009B3A),
                    Color(0xFF002776),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.how_to_vote_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ApurAqui',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -0.3,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Sistema de apuração em tempo real',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Navigation Items List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final isSelected = index == selectedIndex;

                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                const Color(0xFF009B3A).withValues(alpha: 0.1),
                                Colors.transparent,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            )
                          : null,
                    ),
                    child: ListTile(
                      onTap: () {
                        onDestinationSelected(index);
                      },
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Icon(
                            item.icon,
                            color: isSelected
                                ? const Color(0xFF009B3A)
                                : const Color(0xFF9CA3AF),
                            size: 22,
                          ),
                          if (index == 0) // Dashboard (Ao Vivo)
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFEF4444),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: isSelected
                              ? const Color(0xFF009B3A)
                              : const Color(0xFF4B5563),
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF009B3A),
                              size: 18,
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),

            // Footer Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFF9FAFB),
                border: Border(
                  top: BorderSide(color: Color(0xFFF3F4F6), width: 1.0),
                ),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                    onLogoutPressed();
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFFDC2626), // text-red-600
                    size: 20,
                  ),
                  label: const Text(
                    'Sair da Aplicação',
                    style: TextStyle(
                      color: Color(0xFFDC2626), // text-red-600
                      fontWeight: FontWeight.w800, // font-bold
                      fontSize: 14,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFFDC2626),
                    side: const BorderSide(
                      color: Color(0xFFFEE2E2), // border-red-100
                      width: 1.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 1.0,
                    shadowColor: Colors.black.withValues(
                      alpha: 0.05,
                    ), // shadow-sm
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
