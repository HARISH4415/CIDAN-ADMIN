import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BranchHeader extends StatelessWidget {
  final VoidCallback? onSelectBranch;
  final String branchName;
  final String branchCode;

  const BranchHeader({
    super.key,
    this.onSelectBranch,
    this.branchName = 'Anna Nagar Branch',
    this.branchCode = '1234',
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Welcome text
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Welcome Back,',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.3,
                  height: 1.15,
                ),
              ),
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.3,
                  height: 1.15,
                ),
              ),
              SizedBox(height: 3),
              Text(
                "Here's an overview of your branch operations.",
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Branch Selector Card
        InkWell(
          onTap: onSelectBranch ?? () {},
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
            decoration: AppTheme.cardDecoration(radius: 12),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Bank Icon container
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F1FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.account_balance_rounded,
                    color: AppTheme.primaryBlue,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 7),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          branchName,
                          style: const TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textDark,
                          ),
                        ),
                        const SizedBox(width: 2),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: AppTheme.textDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Branch Code: $branchCode',
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppTheme.textMuted,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
