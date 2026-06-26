import 'package:desktop_game_skincare/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('start button opens the organ discovery flow', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('BEYOND\nDRYNESS'), findsWidgets);
    expect(find.text('REFRAMING\nSJ\u00D6GREN\u2019S DISEASE'), findsOneWidget);
    expect(find.text('START THE GAME'), findsOneWidget);

    await tester.tap(find.text('START THE GAME'));
    await tester.pumpAndSettle();

    expect(find.text('TOUCH AN ORGAN TO DISCOVER HOW'), findsOneWidget);
    expect(find.text('SKIN'), findsOneWidget);

    await tester.tap(find.bySemanticsLabel('Open SKIN'));
    await tester.pumpAndSettle();

    expect(
      find.textContaining('This is the next page for skin'),
      findsOneWidget,
    );
  });
}
