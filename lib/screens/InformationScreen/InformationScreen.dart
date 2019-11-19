import 'package:bmi_calculator/models/ScreenArguments.dart';
import 'package:bmi_calculator/screens/ResultScreen/ResultScreen.dart';
import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  static const routeName = "/information";

  @override
  InformationScreenState createState() {
    return InformationScreenState();
  }
}

class InformationScreenState extends State<InformationScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  calculateBMIAndRoute() {
    double bmi = double.parse(weightController.text) /
        ((double.parse(heightController.text) / 10) *
            (double.parse(heightController.text) / 10)) *
        100;

    Navigator.pushNamed(
      context,
      ResultScreen.routeName,
      arguments: ScreenArguments(bmi.toStringAsPrecision(2)),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Form(
          key: _formKey,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
                RaisedButton(
                  onPressed: () {
                    openInformationModal(context);
                  },
                  child: Text('Details'),
                )
              ],
            )),
          )),
    );
  }

  openInformationModal(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute<Null>(
          builder: (BuildContext cx) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Center(
                      child: Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")),
                  Center(
                      child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('BACK'),
                  )),
                ]);
          },
          fullscreenDialog: true,
        ));
  }
}
