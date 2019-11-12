import 'package:flutter/material.dart';
import 'package:bmi_calculator/nav_keys.dart';

class Tab2Screen extends StatefulWidget {
  @override
  _Tab2State createState() => _Tab2State();
}

class _Tab2State extends State<Tab2Screen> {

  @override
  Widget build(BuildContext context) => Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight, // 10% of the width, so there are ten blinds.
          colors: [const Color(0xFF774CD5), const Color(0xFFB74CD5)], // whitish to gray
          tileMode: TileMode.repeated, // repeats the gradient over the canvas
        ),
        color: Colors.white
      ),
      child: RaisedButton(child: Text("Tab 2 - Go to Child"), onPressed: () {
        Keys.tab2Key.currentState.pushNamed("/tab2-child");
      },),
        ),
    )
  );
}