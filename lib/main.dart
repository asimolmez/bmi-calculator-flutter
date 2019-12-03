import 'package:bmi_calculator/screens/CalculatorScreen/CalculatorScreen.dart';
import 'package:bmi_calculator/screens/InformationScreen/InformationScreen.dart';
import 'package:bmi_calculator/screens/ResultScreen/ResultScreen.dart';
import 'package:bmi_calculator/screens/SvgScreen/SvgScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final appTitle = "BMI CALCULATOR";

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        body: this._getBody(_selectedIndex),
        bottomNavigationBar: this._getNavigationBar(),
      ),
      routes: {ResultScreen.routeName: (context) => ResultScreen()}
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return CalculatorScreen();
      case 1:
        return SvgScreen();
      case 2:
        return InformationScreen();
      default:
        return CalculatorScreen();
    }
  }

  Widget _getNavigationBar() {
    return BottomNavigationBar(
      key: Key('bottomNavigation'),
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('Calculator'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Graps'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school),
          title: Text('Information'),
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }
}
