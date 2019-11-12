import 'package:bmi_calculator/nav_keys.dart';
import 'package:bmi_calculator/tab2_child.dart';
import 'package:bmi_calculator/tab2_screen.dart';
import 'package:bmi_calculator/tab_navigator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tab2Navigator extends TabNavigator {
  
  Tab2Navigator();

  Widget build() {
    return CupertinoTabView(
      navigatorKey: Keys.tab2Key,
      builder : (BuildContext context) => CupertinoPageScaffold(child: Tab2Screen()),
      routes : {
        "/tab2-child" : (BuildContext context) => CupertinoPageScaffold(child: Tab2ChildScreen(),)
      }
    );
  }
}