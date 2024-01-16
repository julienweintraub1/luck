import 'package:flutter_test/flutter_test.dart';
import 'package:nfl_players_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(
      {}); // Set initial values here if needed

  testWidgets('App basic UI test', (WidgetTester tester) async {
    // Create a mock instance of SharedPreferences
    final prefs = await SharedPreferences.getInstance();

    // Use the mock instance in the test
    await tester.pumpWidget(MyApp(prefs: prefs));

    expect(find.text('NFL Players List'), findsOneWidget);
    // Additional tests can be added here.
  });
}
