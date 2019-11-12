import 'package:flutter/material.dart';

class Tab2ChildScreen extends StatefulWidget {
  @override
  _Tab2ChildState createState() => _Tab2ChildState();
}

class _Tab2ChildState extends State<Tab2ChildScreen> {

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
        ),
    )
  );
}