import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pie_chart/pie_chart.dart';
import 'components/Bar.dart';

class SvgScreen extends StatefulWidget {
  static const routeName  = "SvgScreen";

  SvgScreen({Key key}) : super(key: key);

  @override
  _SvgScreenState createState() => _SvgScreenState();
}

class _SvgScreenState extends State<SvgScreen> {

   final Map<String, double> dataMap = {
     "GS": 5,
     "FB": 3,
     "BJK": 2,
     "TRBZ": 2
  };
   
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Wrap(
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
      )
    );
  }
}