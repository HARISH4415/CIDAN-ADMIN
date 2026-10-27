import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class IndianBankAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onNotificationsPressed;
  final VoidCallback? onProfilePressed;
  final Uint8List? profileImageBytes;

  const IndianBankAppBar({
    super.key,
    this.onMenuPressed,
    this.onNotificationsPressed,
    this.onProfilePressed,
    this.profileImageBytes,
  });

  @override
  Size get preferredSize => const Size.fromHeight(70);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.indianBankBlue,
      child: SafeArea(
        bottom: false,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              // Menu Hamburger Icon
              IconButton(
                icon: const Icon(
                  Icons.menu_rounded,
                  color: Colors.white,
                  size: 26,
                ),
                onPressed: onMenuPressed ?? () {},
                splashRadius: 22,
                tooltip: 'Menu',
              ),

              const SizedBox(width: 4),

              // Indian Bank Logo in Center / Leading area
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/Indianbank.jpg',
                    height: 50,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Icon(
                            Icons.account_balance,
                            color: AppTheme.indianBankYellow,
                            size: 26,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Indian Bank',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),

              // Notification Bell with Badge
              InkWell(
                onTap: onNotificationsPressed ?? () {},
                borderRadius: BorderRadius.circular(20),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      const Icon(
                        Icons.notifications_none_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                      Positioned(
                        right: -3,
                        top: -3,
                        child: Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: const BoxDecoration(
                            color: Color(0xFFEF4444),
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: const Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Admin Profile Info
              InkWell(
                onTap: onProfilePressed ?? () {},
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 4,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Avatar
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1.2),
                          color: const Color(0xFFE0F2FE),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: profileImageBytes != null
                            ? Image.memory(
                                profileImageBytes!,
                                fit: BoxFit.cover,
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    top: 5,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFFFBBF24),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: -3,
                                    child: Container(
                                      width: 24,
                                      height: 14,
                                      decoration: const BoxDecoration(
                                        color: Color(0xFF00388D),
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    child: Container(
                                      width: 4,
                                      height: 5,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                      const SizedBox(width: 6),
                      // Names
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text(
                                'Admin',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.5,
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(width: 2),
                              Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.white,
                                size: 15,
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Branch Admin',
                            style: TextStyle(
                              color: Color(0xCCFFFFFF),
                              fontSize: 9.5,
                              height: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
