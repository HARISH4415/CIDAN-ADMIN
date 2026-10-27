import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cidan_container_screen.dart';
import '../theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final ValueChanged<String>? onOptionTap;
  final VoidCallback? onLogout;
  final Uint8List? profileImageBytes;
  final ValueChanged<Uint8List?>? onProfileImageChanged;
  final VoidCallback? onCidanTap;

  const ProfileScreen({
    super.key,
    this.onBack,
    this.onOptionTap,
    this.onLogout,
    this.profileImageBytes,
    this.onProfileImageChanged,
    this.onCidanTap,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        onProfileImageChanged?.call(bytes);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not access image: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    }
  }

  Future<void> _openCidan(BuildContext context) async {
    if (onCidanTap != null) {
      onCidanTap!();
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('cidan_is_logged_in') ?? false;
    final savedEmail = prefs.getString('cidan_user_email') ?? '';

    if (!context.mounted) return;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CidanContainerScreen(
          userEmail: (isLoggedIn && savedEmail.isNotEmpty) ? savedEmail : '',
          isLoggedIn: isLoggedIn && savedEmail.isNotEmpty,
        ),
      ),
    );
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Change Profile Photo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(ctx),
                      splashRadius: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F1FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.photo_camera_rounded,
                      color: AppTheme.indianBankBlue,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Take a Photo',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                  subtitle: const Text(
                    'Use device camera',
                    style: TextStyle(fontSize: 11),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(context, ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F1FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.photo_library_rounded,
                      color: AppTheme.indianBankBlue,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.5,
                    ),
                  ),
                  subtitle: const Text(
                    'Select photo from device gallery',
                    style: TextStyle(fontSize: 11),
                  ),
                  onTap: () {
                    Navigator.pop(ctx);
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
                if (profileImageBytes != null) ...[
                  const Divider(color: AppTheme.borderLight),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF1F2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFEF4444),
                        size: 20,
                      ),
                    ),
                    title: const Text(
                      'Remove Profile Photo',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.5,
                        color: Color(0xFFEF4444),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(ctx);
                      onProfileImageChanged?.call(null);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Pinned Header with Back Arrow and Title (Zero gap below AppBar)
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 6, 12, 4),
          child: Row(
            children: [
              InkWell(
                onTap: onBack,
                borderRadius: BorderRadius.circular(20),
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppTheme.textDark,
                    size: 24,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textDark,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ),

        // Scrollable Profile Content (ClampingScrollPhysics eliminates overscroll gap)
        Expanded(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(12, 4, 12, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hero Profile Card with profile-background.png and sbilogo.png
                _buildHeroProfileCard(context),
                const SizedBox(height: 12),

                // 4-item Branch & Role Info Summary Row with strict alignment
                _buildBranchSummaryCard(),
                const SizedBox(height: 14),

                // Menu Group 1: Personal, Contact, Bank & Role, Cidan (Dark Blue Icons)
                _buildMenuGroup(context, [
                  _MenuOption(
                    icon: Icons.person_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Personal Information',
                    subtitle: 'View and update your personal details',
                  ),
                  _MenuOption(
                    icon: Icons.phone_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Contact Details',
                    subtitle: 'Manage your contact information',
                  ),
                  _MenuOption(
                    icon: Icons.account_balance_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Bank & Role Details',
                    subtitle: 'View branch, role and employee information',
                  ),
                  _MenuOption(
                    icon: Icons.shield_outlined,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Cidan',
                    subtitle: 'Regulatory Compliance & Policy AI Engine',
                    badge: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F2FE),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFFBAE6FD),
                          width: 0.8,
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            size: 10,
                            color: Color(0xFF0284C7),
                          ),
                          SizedBox(width: 3),
                          Text(
                            'AI Engine',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF0284C7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
                const SizedBox(height: 12),

                // Menu Group 2: Notifications, App Preferences, Help & Support, About (Dark Blue Icons)
                _buildMenuGroup(context, [
                  _MenuOption(
                    icon: Icons.notifications_none_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Notifications',
                    subtitle: 'Manage your notification preferences',
                  ),
                  _MenuOption(
                    icon: Icons.settings_outlined,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'App Preferences',
                    subtitle: 'Language, theme and display settings',
                  ),
                  _MenuOption(
                    icon: Icons.help_outline_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'Help & Support',
                    subtitle: 'FAQs, user guide and support',
                  ),
                  _MenuOption(
                    icon: Icons.info_outline_rounded,
                    iconColor: AppTheme.indianBankBlue,
                    iconBgColor: const Color(0xFFE8F1FF),
                    title: 'About',
                    subtitle: 'App version, terms and policies',
                  ),
                ]),
                const SizedBox(height: 14),

                // Logout Button
                InkWell(
                  onTap: onLogout,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF1F2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFFECDD3),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.logout_rounded,
                          color: Color(0xFFEF4444),
                          size: 19,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Logout',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFEF4444),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroProfileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/profile-background.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00388D).withValues(alpha: 0.25),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Avatar with Camera Badge (interactive tap to change profile photo)
          Stack(
            children: [
              GestureDetector(
                onTap: () => _showImagePickerModal(context),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2.2),
                    color: const Color(0xFFDCECFE),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: profileImageBytes != null
                      ? Image.memory(profileImageBytes!, fit: BoxFit.cover)
                      : Stack(
                          alignment: Alignment.center,
                          children: [
                            // Head
                            Positioned(
                              top: 10,
                              child: Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFBBF24),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            // Suit
                            Positioned(
                              bottom: -4,
                              child: Container(
                                width: 52,
                                height: 30,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF00388D),
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(26),
                                  ),
                                ),
                              ),
                            ),
                            // Tie & shirt collar
                            Positioned(
                              bottom: 8,
                              child: Container(
                                width: 8,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF38BDF8),
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => _showImagePickerModal(context),
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppTheme.primaryBlue,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.8),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),

          // User details: Admin, Branch Administrator, EMP00123, email, phone
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Admin',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
                const SizedBox(height: 1),
                const Text(
                  'Branch Administrator',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xD9FFFFFF),
                  ),
                ),
                const SizedBox(height: 6),
                _buildContactRow(Icons.person_rounded, 'EMP00123'),
                const SizedBox(height: 2),
                _buildContactRow(
                  Icons.mail_outline_rounded,
                  'admin@indianbank.co.in',
                ),
                const SizedBox(height: 2),
                _buildContactRow(Icons.phone_outlined, '+91 98765 43210'),
              ],
            ),
          ),

          // Indian Bank Logo from assets/sbilogo.png on Right
          Image.asset(
            'assets/sbilogo.png',
            height: 60,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.account_balance,
                    color: AppTheme.indianBankYellow,
                    size: 32,
                  ),
                  SizedBox(height: 3),
                  Text(
                    'Indian Bank',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: const Color(0xB3FFFFFF), size: 12),
        const SizedBox(width: 5),
        Flexible(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 10.5,
              color: Color(0xD9FFFFFF),
              fontWeight: FontWeight.w500,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBranchSummaryCard() {
    return Container(
      decoration: AppTheme.cardDecoration(radius: 12),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 6,
              child: _buildSummarySegment(
                icon: Icons.account_balance_rounded,
                label: 'Branch',
                value: 'Anna Nagar Branch',
              ),
            ),
            _buildDivider(),
            Expanded(
              flex: 4,
              child: _buildSummarySegment(
                icon: Icons.hub_outlined,
                label: 'Branch Code',
                value: '1234',
              ),
            ),
            _buildDivider(),
            Expanded(
              flex: 5,
              child: _buildSummarySegment(
                icon: Icons.shield_outlined,
                label: 'Role',
                value: 'Branch Admin',
              ),
            ),
            _buildDivider(),
            Expanded(
              flex: 5,
              child: _buildSummarySegment(
                icon: Icons.calendar_today_rounded,
                label: 'Joined On',
                value: '15 Aug 2022',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 0.8,
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      color: AppTheme.borderLight,
    );
  }

  Widget _buildSummarySegment({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Uniform icon box
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F1FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppTheme.indianBankBlue, size: 16),
        ),
        const SizedBox(height: 6),
        // Uniform label slot
        SizedBox(
          height: 14,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppTheme.textMuted,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 3),
        // Uniform value slot
        SizedBox(
          height: 16,
          child: Center(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuGroup(BuildContext context, List<_MenuOption> options) {
    return Container(
      decoration: AppTheme.cardDecoration(radius: 14),
      child: Column(
        children: options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isLast = index == options.length - 1;

          return Column(
            children: [
              InkWell(
                onTap: () {
                  if (option.title.toLowerCase() == 'cidan') {
                    _openCidan(context);
                  } else {
                    onOptionTap?.call(option.title);
                  }
                },
                borderRadius: BorderRadius.vertical(
                  top: index == 0 ? const Radius.circular(14) : Radius.zero,
                  bottom: isLast ? const Radius.circular(14) : Radius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    children: [
                      // Leading Icon (Dark Blue)
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: option.iconBgColor,
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Icon(
                          option.icon,
                          color: option.iconColor,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Title, Badge & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  option.title,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppTheme.textDark,
                                  ),
                                ),
                                if (option.badge != null) ...[
                                  const SizedBox(width: 6),
                                  option.badge!,
                                ],
                              ],
                            ),
                            const SizedBox(height: 1),
                            Text(
                              option.subtitle,
                              style: const TextStyle(
                                fontSize: 10.5,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Chevron right
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppTheme.textLight,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                const Padding(
                  padding: EdgeInsets.only(left: 56, right: 12),
                  child: Divider(height: 1, color: AppTheme.borderLight),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuOption {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final Widget? badge;

  const _MenuOption({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    this.badge,
  });
}
