// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:bmi_calculator/helpers/CommonHelper.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('enter height', () async {
      final SerializableFinder heightInput = find.byValueKey('heightForm');
      await driver.tap(heightInput);
      expect(heightInput, isNotNull);
      await driver.waitFor(heightInput);
      await driver.enterText('180');
      await driver.waitFor(find.text('180'));
    });

    test('enter weight', () async {
      final SerializableFinder weightInput = find.byValueKey("weightForm");
      await driver.tap(weightInput);
      expect(weightInput, isNotNull);
      await driver.waitFor(weightInput);
      await driver.enterText('90');
      await driver.waitFor(find.text('90'));
    });

    test('click submit', () async {
      final SerializableFinder calculateButton = find.byValueKey("calculateButton");
      await driver.waitFor(calculateButton);
      await driver.tap(calculateButton);
    });

    test('test result page', () async {
      var bmiResult = CommonHelper.getBMI("90", "180").toStringAsPrecision(2);

      final SerializableFinder resultObj = find.byValueKey("resultText");
      await driver.waitFor(resultObj);
      expect(resultObj, isNotNull);
      var resultText;
      await driver.getText(resultObj).then((s) {
        print(s);
        resultText = s;
      });

      expect(resultText, "Your BMI rate is: " + bmiResult);
    });
  });
}
