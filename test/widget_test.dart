import 'package:flutter_test/flutter_test.dart';
import 'package:cidan_admin/main.dart';

import 'package:flutter/material.dart';
import 'package:cidan/cidan.dart';
import 'package:cidan_admin/screens/cidan_container_screen.dart';

void main() {
  testWidgets('Indian Bank Admin dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const IndianBankAdminApp());
    expect(find.text('Admin'), findsWidgets);
    expect(find.text('Anna Nagar Branch'), findsOneWidget);
  });

  testWidgets('Cidan application test for existing user (Upload screen)', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: cidan.application(
        userEmail: 'admin@indianbank.co.in',
        isLoggedIn: true,
        standalone: false,
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('Cidan application test for new user (Login screen)', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: cidan.application(
        isLoggedIn: false,
        userEmail: '',
        standalone: false,
      ),
    ));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));
  });

  testWidgets('CidanContainerScreen back button returns to previous screen', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (ctx) => TextButton(
            onPressed: () {
              Navigator.of(ctx).push(
                MaterialPageRoute(
                  builder: (_) => const CidanContainerScreen(
                    isLoggedIn: false,
                    userEmail: '',
                  ),
                ),
              );
            },
            child: const Text('Open Cidan'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Open Cidan'));
    await tester.pumpAndSettle();

    // Verify CIDAN header is visible
    expect(find.text('CIDAN Compliance AI'), findsOneWidget);

    // Tap back button
    await tester.tap(find.byIcon(Icons.arrow_back_rounded));
    await tester.pumpAndSettle();

    // Verify we are back on the previous screen
    expect(find.text('Open Cidan'), findsOneWidget);
  });
}
