import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mini_chat_ai_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('user can open chat and send message', (tester) async {
    // Start full app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Tap first user
    await tester.tap(find.text('Aman'));
    await tester.pumpAndSettle();

    // Enter message
    await tester.enterText(
      find.byType(TextField),
      'Hello',
    );

    // Send message
    await tester.tap(find.byIcon(Icons.send));
    await tester.pumpAndSettle();

    // Verify message appears
    expect(find.text('Hello'), findsOneWidget);
  });
}
