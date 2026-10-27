import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IndianBankBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int>? onTap;

  const IndianBankBottomNav({
    super.key,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = [
      _NavItem(
        activeIcon: Icons.home_rounded,
        inactiveIcon: Icons.home_outlined,
        label: 'Dashboard',
      ),
      _NavItem(
        activeIcon: Icons.person_rounded,
        inactiveIcon: Icons.person_outline_rounded,
        label: 'Profile',
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: navItems.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  final isSelected = index == currentIndex;

                  return Expanded(
                    child: InkWell(
                      onTap: () => onTap?.call(index),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Top Active Indicator line
                          Container(
                            height: 3,
                            width: 44,
                            decoration: BoxDecoration(
                              color: isSelected ? AppTheme.primaryBlue : Colors.transparent,
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(2),
                                bottomRight: Radius.circular(2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Icon(
                            isSelected ? item.activeIcon : item.inactiveIcon,
                            color: isSelected ? AppTheme.primaryBlue : AppTheme.textMuted,
                            size: 24,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item.label,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                              color: isSelected ? AppTheme.primaryBlue : AppTheme.textMuted,
                            ),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData activeIcon;
  final IconData inactiveIcon;
  final String label;

  const _NavItem({
    required this.activeIcon,
    required this.inactiveIcon,
    required this.label,
  });
}
