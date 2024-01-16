import 'package:flutter_test/flutter_test.dart';
import 'package:nfl_players_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  testWidgets('App basic UI test', (WidgetTester tester) async {
    // Create a mock instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Use the mock instance in the test
    await tester.pumpWidget(MyApp(prefs: prefs));

    // Basic UI test for the presence of the NFL Players List title
    expect(find.text('NFL Players List'), findsOneWidget);
    // Additional UI tests can be added here as needed.
  });
}
