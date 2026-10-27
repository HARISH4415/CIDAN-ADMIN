import 'package:flutter_test/flutter_test.dart';
import 'package:cidan_admin/main.dart';

void main() {
  testWidgets('Indian Bank Admin dashboard smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const IndianBankAdminApp());
    expect(find.text('Admin'), findsWidgets);
    expect(find.text('Anna Nagar Branch'), findsOneWidget);
  });
}
