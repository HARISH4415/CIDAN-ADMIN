import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final VoidCallback? onViewAll;
  final ValueChanged<String>? onActionTap;

  const QuickActionsSection({
    super.key,
    this.onViewAll,
    this.onActionTap,
  });

  @override
  Widget build(BuildContext context) {
    // 8 actions arranged in pairs matching the 2-column grid in the reference image:
    // Row 1: Customer Management | Account Approval
    // Row 2: Loan Processing     | KYC Verification
    // Row 3: Transaction Mon.    | Reports & MIS
    // Row 4: Service Requests    | User Management
    final actionPairs = [
      [
        _ActionItem(
          title: 'Customer\nManagement',
          icon: Icons.people_alt_rounded,
          iconColor: const Color(0xFF1D72FE),
          iconBgColor: const Color(0xFFE8F1FF),
        ),
        _ActionItem(
          title: 'Account\nApproval',
          icon: Icons.check_circle_rounded,
          iconColor: const Color(0xFF00C48C),
          iconBgColor: const Color(0xFFE6F9F0),
          customWidget: _buildAccountApprovalBadge(),
        ),
      ],
      [
        _ActionItem(
          title: 'Loan\nProcessing',
          icon: Icons.settings_rounded,
          iconColor: const Color(0xFF9333EA),
          iconBgColor: const Color(0xFFF3E8FF),
        ),
        _ActionItem(
          title: 'KYC\nVerification',
          icon: Icons.badge_rounded,
          iconColor: const Color(0xFFF59E0B),
          iconBgColor: const Color(0xFFFEF3C7),
          customWidget: _buildKycBadge(),
        ),
      ],
      [
        _ActionItem(
          title: 'Transaction\nMonitoring',
          icon: Icons.swap_horiz_rounded,
          iconColor: const Color(0xFFF43F5E),
          iconBgColor: const Color(0xFFFEE2E2),
        ),
        _ActionItem(
          title: 'Reports & MIS',
          icon: Icons.bar_chart_rounded,
          iconColor: const Color(0xFF0D9488),
          iconBgColor: const Color(0xFFE0F7F6),
        ),
      ],
      [
        _ActionItem(
          title: 'Service\nRequests',
          icon: Icons.headset_mic_rounded,
          iconColor: const Color(0xFFF97316),
          iconBgColor: const Color(0xFFFFEDD5),
        ),
        _ActionItem(
          title: 'User\nManagement',
          icon: Icons.hub_rounded,
          iconColor: const Color(0xFF2563EB),
          iconBgColor: const Color(0xFFDBEAFE),
        ),
      ],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
                letterSpacing: -0.3,
              ),
            ),
            InkWell(
              onTap: onViewAll ?? () {},
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1D72FE),
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 16,
                      color: Color(0xFF1D72FE),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // 4 Rows of 2 cards each
        ...actionPairs.asMap().entries.map((entry) {
          final isLast = entry.key == actionPairs.length - 1;
          final pair = entry.value;
          return Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 10),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _buildActionCard(pair[0])),
                  const SizedBox(width: 10),
                  Expanded(child: _buildActionCard(pair[1])),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildActionCard(_ActionItem item) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onActionTap?.call(item.title.replaceAll('\n', ' ')),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFEFF2F7),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF0F172A).withValues(alpha: 0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              // Colored Icon Box
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: item.iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: item.customWidget != null
                      ? FittedBox(
                          fit: BoxFit.scaleDown,
                          child: item.customWidget!,
                        )
                      : Icon(
                          item.icon,
                          color: item.iconColor,
                          size: 22,
                        ),
                ),
              ),
              const SizedBox(width: 10),
              // Action Title
              Expanded(
                child: Text(
                  item.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1E293B),
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(width: 2),
              // Trailing Chevron
              const Icon(
                Icons.chevron_right_rounded,
                size: 20,
                color: Color(0xFF94A3B8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Account Approval Badge (matching the green card with checkmark from image)
  static Widget _buildAccountApprovalBadge() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 2,
          decoration: BoxDecoration(
            color: const Color(0xFF00A876),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(height: 1.5),
        Container(
          width: 25,
          height: 23,
          decoration: BoxDecoration(
            color: const Color(0xFF00C48C),
            borderRadius: BorderRadius.circular(5.5),
          ),
          child: const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Icon(
                Icons.check_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Custom KYC Badge (matching the amber ID card badge from image)
  static Widget _buildKycBadge() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 7,
          height: 2,
          decoration: BoxDecoration(
            color: const Color(0xFFD97706),
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        const SizedBox(height: 1.5),
        Container(
          width: 26,
          height: 23,
          decoration: BoxDecoration(
            color: const Color(0xFFF59E0B),
            borderRadius: BorderRadius.circular(5.5),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2.5),
          child: const Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 12,
                  ),
                  SizedBox(width: 2),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 5,
                        height: 1.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0.8)),
                          ),
                        ),
                      ),
                      SizedBox(height: 2),
                      SizedBox(
                        width: 3.5,
                        height: 1.8,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(0.8)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final Widget? customWidget;

  const _ActionItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.customWidget,
  });
}
