import 'package:bmi_calculator/models/ScreenArguments.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result';

  @override
  Widget build(BuildContext context) {
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text("Result"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Center(child: Text('Your BMI rate is: ' + args.bmiValue)),
              Center(
                  child: RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('BACK'),
              )),
            ]));
  }
}
