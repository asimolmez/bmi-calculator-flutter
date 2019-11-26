import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/screens/CalculatorScreen/CalculatorScreen.dart';
import 'package:bmi_calculator/helpers/CommonHelper.dart';

void main() {
  testWidgets('my first widget test', (WidgetTester tester) async {
    var pressed = false;
    var widget = CalculatorScreen();

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return MaterialApp(
            home: Material(
              child: Center(
                child: widget,
              ),
            ),
          );
        },
      ),
    );

    var heightForm = find.byKey(Key('heightForm'));
    var weightForm = find.byKey(Key('weightForm'));

    await tester.enterText(heightForm, "180");
    await tester.enterText(weightForm, "90");
    await tester.pump();

    expect(find.text('180'), findsOneWidget);
    expect(find.text('90'), findsOneWidget);

    expect(() {return CommonHelper.getBMI("90", "180");}, returnsNormally);
  });
}
