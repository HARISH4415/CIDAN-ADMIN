import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class MetricCardsSection extends StatelessWidget {
  const MetricCardsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      _MetricData(
        icon: Icons.people_alt_rounded,
        iconColor: AppTheme.primaryBlue,
        iconBgColor: const Color(0xFFE8F1FF),
        value: '1,248',
        title: 'Total Customers',
        growth: '+12%',
      ),
      _MetricData(
        icon: Icons.account_balance_wallet_rounded,
        iconColor: AppTheme.warningAmber,
        iconBgColor: AppTheme.warningAmberBg,
        value: '₹ 24.8 Cr',
        title: 'Total Deposits',
        growth: '+8%',
      ),
      _MetricData(
        icon: Icons.savings_rounded,
        iconColor: AppTheme.purpleAccent,
        iconBgColor: AppTheme.purpleAccentBg,
        value: '₹ 18.6 Cr',
        title: 'Total Loans',
        growth: '+10%',
      ),
      _MetricData(
        icon: Icons.receipt_long_rounded,
        iconColor: AppTheme.roseAccent,
        iconBgColor: AppTheme.roseAccentBg,
        value: '3,842',
        title: 'Transactions',
        growth: '+15%',
      ),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: metrics.asMap().entries.map((entry) {
          final index = entry.key;
          final data = entry.value;
          return Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: index < metrics.length - 1 ? 6.0 : 0.0,
              ),
              child: _buildMetricCard(data),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMetricCard(_MetricData data) {
    return Container(
      decoration: AppTheme.cardDecoration(),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Icon Box
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: data.iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              data.icon,
              color: data.iconColor,
              size: 17,
            ),
          ),
          const SizedBox(height: 8),

          // Metric Value (Fixed baseline slot)
          SizedBox(
            height: 20,
            child: Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  data.value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.textDark,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ),
          ),

          // Metric Title (Fixed baseline slot)
          SizedBox(
            height: 15,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                data.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppTheme.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Growth indicator (Fixed baseline slot)
          SizedBox(
            height: 14,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_upward_rounded,
                  size: 11,
                  color: AppTheme.successGreen,
                ),
                const SizedBox(width: 1),
                Text(
                  data.growth,
                  style: const TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.successGreen,
                  ),
                ),
              ],
            ),
          ),

          // 'vs last month' (Fixed baseline slot)
          const SizedBox(
            height: 13,
            child: Text(
              'vs last month',
              style: TextStyle(
                fontSize: 8.5,
                color: AppTheme.textLight,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricData {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String value;
  final String title;
  final String growth;

  const _MetricData({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.value,
    required this.title,
    required this.growth,
  });
}
