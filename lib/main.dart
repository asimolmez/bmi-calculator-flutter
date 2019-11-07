import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = "BMI CALCULATOR";

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final weightController = TextEditingController();
  final heightController = TextEditingController();

  String bmiResult = "";

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
                TextFormField(
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
                      calculateBMI();
                    }
                  },
                  child: Text('Submit'),
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      bmiResult == null ? "" : bmiResult,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                    ))
              ],
            )),
          )),
    );
  }

  calculateBMI() {
    double bmi = double.parse(weightController.text) /
        ((double.parse(heightController.text) / 10) *
            (double.parse(heightController.text) / 10)) *
        100;

    setState(() {
      bmiResult = bmi.toStringAsFixed(2);
    });
  }
}
