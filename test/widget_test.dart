import 'package:flutter_test/flutter_test.dart';
import 'package:activity/app/activity_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: ActivityApp()));

    // Verify that the initialization text is present.
    expect(find.text('Activity App Initialized'), findsOneWidget);
  });
}
