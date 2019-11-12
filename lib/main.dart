import 'package:bmi_calculator/tab_container.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appTitle = "BMI CALCULATOR";

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(title: Text(appTitle)),
        body: MainScreen(),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              title: Text('Business'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              title: Text('School'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
      routes: {
        ResultScreen.routeName: (context) => ResultScreen(),
        "/app" : (context) => TabContainerWidget()
      },
    );
  }
}

openInformationModal(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute<Null>(
        builder: (BuildContext cx) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(child: Text("It is simple app.")),
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

// Create a Form widget.
class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState() {
    return MainScreenState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MainScreenState extends State<MainScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
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
                      calculateBMIAndRoute();
                    }
                  },
                  child: Text('Submit'),
                ),
                RaisedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    // openInformationModal(context);
                        Navigator.pushNamed(
                          context,
                          "/app"
                        );
                  },
                  child: Text('Information'),
                )
              ],
            )),
          )),
    );
  }
}

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

// You can pass any object to the arguments parameter.
// In this example, create a class that contains a customizable
// title and message.
class ScreenArguments {
  ScreenArguments(this.bmiValue);

  final String bmiValue;
}
