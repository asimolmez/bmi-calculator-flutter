import 'package:bmi_calculator/tab_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:simple_animations/simple_animations.dart';

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
        "/app": (context) => TabContainerWidget()
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
                    openInformationModal(context);
                  },
                  child: Text('Information'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/app");
                  },
                  child: Text('Open Tabbed Navigation'),
                ),
                RaisedButton(
                  onPressed: () {
                    _showGeneralDialog(context);
                  },
                  child: Text('Open Modal'),
                )
              ],
            )),
          )),
    );
  }
}

void _settingModalBottomSheet(context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return Container(
        child: new Wrap(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.music_note),
                title: new Text('Music'),
                onTap: () => {}),
            new ListTile(
              leading: new Icon(Icons.videocam),
              title: new Text('Video'),
              onTap: () => {},
            ),
          ],
        ),
      );
    },
    isScrollControlled: true,
  );
}

void _showGeneralDialog(context) {
  Map<String, double> dataMap = new Map();
  dataMap.putIfAbsent("GS", () => 5);
  dataMap.putIfAbsent("FB", () => 3);
  dataMap.putIfAbsent("BJK", () => 2);
  dataMap.putIfAbsent("TRBZ", () => 2);

  showGeneralDialog(
    context: context,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return Wrap(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 50,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: SvgPicture.network(
                    "https://www.svgrepo.com/show/2046/dog.svg",
                    placeholderBuilder: (context) => CircularProgressIndicator(),
                    height: 128.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: PieChart(
                    dataMap: dataMap,
                    legendFontColor: Colors.blueGrey[900],
                    legendFontSize: 14.0,
                    legendFontWeight: FontWeight.w500,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32.0,
                    chartRadius: 100,
                    showChartValuesInPercentage: true,
                    showChartValues: true,
                    chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                ),Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Bar(0.3, "2013"),
                      Bar(0.5, "2014"),
                      Bar(0.7, "2015"),
                      Bar(0.8, "2016"),
                      Bar(0.2, "2017"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    },
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black,
    transitionDuration: const Duration(milliseconds: 200),
  );
}

class Bar extends StatelessWidget {
  final double height;
  final String label;

  final int _baseDurationMs = 1000;
  final double _maxElementHeight = 100;

  Bar(this.height, this.label);

  @override
  Widget build(BuildContext context) {
    return ControlledAnimation(
      duration: Duration(milliseconds: (height * _baseDurationMs).round()),
      tween: Tween(begin: 0.0, end: height),
      builder: (context, animatedHeight) {
        return Column(
          children: <Widget>[
            Container(
              height: (1 - animatedHeight) * _maxElementHeight,
            ),
            Container(
              width: 20,
              height: animatedHeight * _maxElementHeight,
              color: Colors.blue,
            ),
            Text(label, style: TextStyle(
              fontSize: 12,
              color: Colors.grey[300],
            ))

          ],
        );
      },
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
