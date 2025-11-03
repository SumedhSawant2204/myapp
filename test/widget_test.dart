import 'package:flutter_test/flutter_test.dart';
import 'package:myapp/src/app.dart';
import 'package:myapp/src/presentation/pages/main_page.dart';

void main() {
  testWidgets('App starts and displays MainPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the MainPage is displayed.
    expect(find.byType(MainPage), findsOneWidget);
  });
}
