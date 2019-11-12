import 'package:flutter/material.dart';

class Tab1Screen extends StatefulWidget {
  @override
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1Screen> {

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
      child: Text("Tab 1"),
        ),
    )
  );
}