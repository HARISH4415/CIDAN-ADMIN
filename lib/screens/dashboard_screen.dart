import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/app_bar_header.dart';
import '../widgets/branch_header.dart';
import '../widgets/metric_cards_section.dart';
import '../widgets/charts_section.dart';
import '../widgets/quick_actions_section.dart';
import '../widgets/activity_section.dart';
import '../widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cidan_container_screen.dart';
import 'profile_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentNavIndex = 0;
  Uint8List? _profileImageBytes;

  Future<void> _openCidanSuite() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('cidan_is_logged_in') ?? false;
    final savedEmail = prefs.getString('cidan_user_email') ?? '';

    if (!mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CidanContainerScreen(
          userEmail: (isLoggedIn && savedEmail.isNotEmpty) ? savedEmail : '',
          isLoggedIn: isLoggedIn && savedEmail.isNotEmpty,
        ),
      ),
    );
  }

  void _showNotificationSnackBar(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppTheme.indianBankBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundLight,
      appBar: IndianBankAppBar(
        profileImageBytes: _profileImageBytes,
        onMenuPressed: () {
          _showNotificationSnackBar('Navigation Menu opened');
        },
        onNotificationsPressed: () {
          _showNotificationSnackBar('You have 3 unread notifications');
        },
        onProfilePressed: () {
          setState(() {
            _currentNavIndex = 1;
          });
        },
      ),
      body: SafeArea(
        top: false,
        child: _currentNavIndex == 0
            ? _buildDashboardView()
            : ProfileScreen(
                profileImageBytes: _profileImageBytes,
                onProfileImageChanged: (bytes) {
                  setState(() {
                    _profileImageBytes = bytes;
                  });
                  _showNotificationSnackBar(
                    bytes != null
                        ? 'Profile image updated successfully'
                        : 'Profile image reset to default',
                  );
                },
                onBack: () {
                  setState(() {
                    _currentNavIndex = 0;
                  });
                },
                onOptionTap: (option) {
                  if (option.toLowerCase() == 'cidan') {
                    _openCidanSuite();
                  } else {
                    _showNotificationSnackBar('Opened: $option');
                  }
                },
                onCidanTap: _openCidanSuite,
                onLogout: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
      ),
      bottomNavigationBar: IndianBankBottomNav(
        currentIndex: _currentNavIndex,
        onTap: (index) {
          setState(() {
            _currentNavIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDashboardView() {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Welcome greeting & Branch Selector
          BranchHeader(
            onSelectBranch: () {
              _showBranchSelectionModal(context);
            },
          ),
          const SizedBox(height: 12),

          // 4 Metric Overview Cards
          const MetricCardsSection(),
          const SizedBox(height: 12),

          // Charts: Deposits vs Loans & Customer Growth
          const ChartsSection(),
          const SizedBox(height: 12),

          // Quick Actions Grid
          QuickActionsSection(
            onViewAll: () {
              _showNotificationSnackBar('Opening all Quick Actions');
            },
            onActionTap: (action) {
              _showNotificationSnackBar('Opened: $action');
            },
          ),
          const SizedBox(height: 12),

          // Recent Transactions & Pending Approvals
          ActivitySection(
            onViewAllTransactions: () {
              _showNotificationSnackBar('Viewing all Transactions');
            },
            onViewAllApprovals: () {
              _showNotificationSnackBar('Viewing all Pending Approvals (12)');
            },
          ),
          const SizedBox(height: 14),
        ],
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: const [
              Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
              SizedBox(width: 8),
              Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
          content: const Text(
            'Are you sure you want to sign out of the Indian Bank Admin portal?',
            style: TextStyle(fontSize: 13, color: AppTheme.textMuted),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text(
                'Cancel',
                style: TextStyle(color: AppTheme.textMuted),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEF4444),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.pop(ctx);
                _showNotificationSnackBar('Logged out successfully');
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showBranchSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Select Branch',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _buildBranchTile('Anna Nagar Branch', '1234', true, ctx),
              _buildBranchTile('T. Nagar Branch', '1235', false, ctx),
              _buildBranchTile('Adyar Branch', '1236', false, ctx),
              _buildBranchTile('Velachery Branch', '1237', false, ctx),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBranchTile(
    String name,
    String code,
    bool isSelected,
    BuildContext ctx,
  ) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F1FF) : const Color(0xFFF1F5F9),
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.account_balance_rounded,
          color: isSelected ? AppTheme.primaryBlue : AppTheme.textMuted,
          size: 20,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
          color: isSelected ? AppTheme.primaryBlue : AppTheme.textDark,
          fontSize: 14,
        ),
      ),
      subtitle: Text(
        'Branch Code: $code',
        style: const TextStyle(fontSize: 12),
      ),
      trailing: isSelected
          ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryBlue)
          : null,
      onTap: () {
        Navigator.pop(ctx);
        _showNotificationSnackBar('Switched to $name ($code)');
      },
    );
  }
}
