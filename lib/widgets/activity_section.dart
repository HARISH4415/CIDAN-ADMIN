import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ActivitySection extends StatelessWidget {
  final VoidCallback? onViewAllTransactions;
  final VoidCallback? onViewAllApprovals;

  const ActivitySection({
    super.key,
    this.onViewAllTransactions,
    this.onViewAllApprovals,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Recent Transactions Card
          Expanded(
            child: Container(
              decoration: AppTheme.cardDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      _buildViewAllLink(onViewAllTransactions),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Transaction items
                  _buildTransactionItem(
                    icon: Icons.arrow_downward_rounded,
                    iconColor: AppTheme.successGreen,
                    iconBgColor: AppTheme.successGreenBg,
                    amount: '₹ 50,000',
                    type: 'Fund Transfer',
                    time: '2 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionItem(
                    icon: Icons.arrow_upward_rounded,
                    iconColor: AppTheme.primaryBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    amount: '₹ 1,25,000',
                    type: 'Loan Disbursement',
                    time: '10 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionItem(
                    icon: Icons.person_rounded,
                    iconColor: AppTheme.warningAmber,
                    iconBgColor: AppTheme.warningAmberBg,
                    amount: '₹ 10,000',
                    type: 'Account Opening',
                    time: '25 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildTransactionItem(
                    icon: Icons.credit_card_rounded,
                    iconColor: AppTheme.roseAccent,
                    iconBgColor: AppTheme.roseAccentBg,
                    amount: '₹ 5,000',
                    type: 'Card Payment',
                    time: '1 hour ago',
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Pending Approvals Card
          Expanded(
            child: Container(
              decoration: AppTheme.cardDecoration(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Header
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          'Pending Approvals',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Red counter pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: const Text(
                          '12',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      _buildViewAllLink(onViewAllApprovals),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // Approvals items
                  _buildApprovalItem(
                    icon: Icons.badge_rounded,
                    iconBgColor: AppTheme.primaryBlue,
                    title: 'Account Opening Request',
                    person: 'Priya S.',
                    time: '10 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildApprovalItem(
                    icon: Icons.description_rounded,
                    iconBgColor: AppTheme.primaryBlue,
                    title: 'Loan Application',
                    person: 'Karthik R.',
                    time: '25 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildApprovalItem(
                    icon: Icons.verified_user_rounded,
                    iconBgColor: AppTheme.warningAmber,
                    title: 'KYC Verification',
                    person: 'Meena K.',
                    time: '40 mins ago',
                  ),
                  const SizedBox(height: 10),
                  _buildApprovalItem(
                    icon: Icons.miscellaneous_services_rounded,
                    iconBgColor: AppTheme.roseAccent,
                    title: 'Service Request',
                    person: 'Ravi T.',
                    time: '1 hour ago',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllLink(VoidCallback? onTap) {
    return InkWell(
      onTap: onTap ?? () {},
      borderRadius: BorderRadius.circular(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'View All',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryBlue,
            ),
          ),
          SizedBox(width: 2),
          Icon(
            Icons.arrow_forward_rounded,
            size: 12,
            color: AppTheme.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String amount,
    required String type,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Leading Icon circle
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: iconBgColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 16,
          ),
        ),
        const SizedBox(width: 6),
        // Title & type
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              Text(
                type,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 4),
        // Time & Success badge
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 9,
                color: AppTheme.textLight,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1.5),
              decoration: BoxDecoration(
                color: AppTheme.successGreenBg,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Success',
                style: TextStyle(
                  color: AppTheme.successGreen,
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildApprovalItem({
    required IconData icon,
    required Color iconBgColor,
    required String title,
    required String person,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Leading Icon rounded rect
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 6),
        // Title & details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 1),
              Text(
                '$person  •  $time',
                style: const TextStyle(
                  fontSize: 9.5,
                  color: AppTheme.textMuted,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right_rounded,
          size: 16,
          color: AppTheme.textLight,
        ),
      ],
    );
  }
}
