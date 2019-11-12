import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/nav_keys.dart';
//
import 'package:bmi_calculator/tab1_navigator.dart';
import 'package:bmi_calculator/tab2_navigator.dart';

///Doc for navigation mechanism is below : 
///https://medium.com/coding-with-flutter/flutter-case-study-multiple-navigators-with-bottomnavigationbar-90eb6caa6dbf

class TabContainerWidget extends StatefulWidget {

  @override
  _TabContainerWidgetState createState() => _TabContainerWidgetState();
}

class _TabContainerWidgetState extends State<TabContainerWidget> {

  List<CupertinoTabView> tabContainers;

  _TabContainerWidgetState() {

    tabContainers = <CupertinoTabView>[
      Tab1Navigator().build(),
      Tab2Navigator().build()
    ];
  }

  @override
  Widget build(BuildContext context) {
    
    return CupertinoTabScaffold(
            tabBar: CupertinoTabBar(
              key: Keys.tabbar,
              backgroundColor : Color.fromARGB(255, 220, 220, 200),
              items: <BottomNavigationBarItem> [
                  buildTabItem("Tab 1", Icons.home),
                  buildTabItem("Tab 2", Icons.games),
              ],
            ),
            tabBuilder: (BuildContext context, int index) {
              return tabContainers[index];
            },
          );
  }
  
  BottomNavigationBarItem buildTabItem(String title, IconData icon) {
    
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}