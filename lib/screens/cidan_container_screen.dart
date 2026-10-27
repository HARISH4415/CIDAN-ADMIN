import 'package:flutter/material.dart';
import 'package:cidan/cidan.dart';

/// Container screen that safely hosts the CIDAN Compliance AI Suite.
///
/// Features:
/// 1. Dedicated AppBar with a back button returning to the parent app.
/// 2. Isolated inner [Navigator] so CIDAN's internal navigation (e.g. OTP -> Upload)
///    never clears or corrupts the parent application's route stack.
/// 3. [PopScope] handling hardware / gesture back buttons to pop inner routes first,
///    then pop back to Profile screen without closing the application.
class CidanContainerScreen extends StatefulWidget {
  final bool isLoggedIn;
  final String userEmail;

  const CidanContainerScreen({
    super.key,
    required this.isLoggedIn,
    required this.userEmail,
  });

  @override
  State<CidanContainerScreen> createState() => _CidanContainerScreenState();
}

class _CidanContainerScreenState extends State<CidanContainerScreen> {
  final GlobalKey<NavigatorState> _cidanNavKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        if (_cidanNavKey.currentState?.canPop() ?? false) {
          _cidanNavKey.currentState?.pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,

        body: Navigator(
          key: _cidanNavKey,
          onGenerateRoute: (settings) {
            return MaterialPageRoute(
              builder: (_) => cidan.application(
                userEmail: widget.userEmail,
                isLoggedIn: widget.isLoggedIn,
                standalone: false,
              ),
            );
          },
        ),
      ),
    );
  }
}
