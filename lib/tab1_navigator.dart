import 'package:bmi_calculator/tab1_screen.dart';
import 'package:bmi_calculator/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/nav_keys.dart';

class Tab1Navigator extends TabNavigator {
  
  Tab1Navigator();

  Widget build() {
    return CupertinoTabView(
      navigatorKey: Keys.tab1Key,
      builder : (BuildContext context) => CupertinoPageScaffold(child: Tab1Screen()),
      routes : {
        // "/trivia" : (BuildContext context) => CupertinoPageScaffold(child: TriviaScreen())
      }
    );
  }
}