// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';
import 'package:bmi_calculator/helpers/CommonHelper.dart';
import 'dart:io';

int screenShotCounter = 1;

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

    String folderName = "test_driver/test_output/";
    String deviceName = "";

    test('creating test files folders', () async {
      String deviceNameFile = "test_driver/test_output/current_device";
      File file = new File(deviceNameFile);
      Future<String> futureContent = file.readAsString();
      futureContent.then((c) => deviceName = c.trim());
    });

    test('enter height', () async {
      final SerializableFinder heightInput = find.byValueKey('heightForm');
      await driver.tap(heightInput);
      expect(heightInput, isNotNull);
      await driver.waitFor(heightInput);
      await driver.enterText('180');
      await driver.waitFor(find.text('180'));

      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
    });

    test('enter weight', () async {
      final SerializableFinder weightInput = find.byValueKey("weightForm");
      await driver.tap(weightInput);
      expect(weightInput, isNotNull);
      await driver.waitFor(weightInput);
      await driver.enterText('90');
      await driver.waitFor(find.text('90'));
      await _captureScreenShot(driver, folderName, deviceName, "BMI_Screen");
      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
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
      await _captureScreenShot(driver, folderName, deviceName, "BMI_Result");
      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds

      final SerializableFinder goBackButton = find.byValueKey("goBackButton");
      await driver.waitFor(goBackButton);
      await driver.tap(goBackButton);

      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
    });

    test('switch information tab', () async {
      await driver.waitFor(find.byValueKey('bottomNavigation'));
      await driver.tap(find.text('Graps'));
      await driver.waitFor(find.text("TRBZ"));
      await _captureScreenShot(driver, folderName, deviceName, "Graphs_Tab");
      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
      await driver.tap(find.text('Information'));
      await driver.waitForAbsent(find.text("TRBZ"));
      await _captureScreenShot(driver, folderName, deviceName, "Information_Tab");
      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds

      final SerializableFinder detailsModalButton = find.byValueKey("detailsModalButton");
      await driver.waitFor(detailsModalButton);
      await driver.scrollIntoView(detailsModalButton);
      await _captureScreenShot(driver, folderName, deviceName, "Information_Tab_Scrolled");
      //await driver.waitFor(find.text('Scroll till here'));
      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
      await driver.tap(detailsModalButton);
      await _captureScreenShot(driver, folderName, deviceName, "Information_Detail_Modal");

      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
      final SerializableFinder detailsModalCloseButton = find.byValueKey("detailsModalCloseButton");
      await driver.waitFor(detailsModalCloseButton);
      await driver.tap(detailsModalCloseButton);

      await new Future.delayed(const Duration(seconds: 1)); // wait 1 seconds
      await driver.tap(find.text('Calculator'));
    });
  });
}

_captureScreenShot(FlutterDriver driver, String folderName, String deviceName, String fileName) async {
  final String path = folderName + deviceName + "_" + screenShotCounter.toString() + "_" + fileName + ".png";
  await driver.waitUntilNoTransientCallbacks();
  final List<int> pixels = await driver.screenshot();
  final File file = new File(path);
  await file.writeAsBytes(pixels);
  print('wrote $file');

  screenShotCounter++;
}
