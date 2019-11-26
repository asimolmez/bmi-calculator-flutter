import 'package:bmi_calculator/helpers/CommonHelper.dart';
import 'package:bmi_calculator/models/ScreenArguments.dart';
import 'package:bmi_calculator/screens/ResultScreen/ResultScreen.dart';
import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  static const routeName = "/calculator";
  @override
  CalculatorScreenState createState() {
    return CalculatorScreenState();
  }
}

class CalculatorScreenState extends State<CalculatorScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  calculateBMIAndRoute() {
    double bmi = CommonHelper.getBMI(weightController.text, heightController.text);

    Navigator.pushNamed(
      context,
      ResultScreen.routeName,
      arguments: ScreenArguments(bmi.toStringAsPrecision(2)),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                TextFormField(
                  key: Key('heightForm'),
                  controller: heightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintText: "cm", labelText: "Height"),
                  keyboardType: TextInputType.number,
                ),
                TextFormField(
                  key: Key('weightForm'),
                  controller: weightController,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                  decoration:
                      InputDecoration(hintText: "kg", labelText: "Weight"),
                  keyboardType: TextInputType.number,
                ),
                RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    if (_formKey.currentState.validate()) {
                      calculateBMIAndRoute();
                    }
                  },
                  child: Text('Submit'),
                )
              ],
            )),
          )),
    );
  }
}
