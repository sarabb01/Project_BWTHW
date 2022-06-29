import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Screens/PointsScreens/pointsPage.dart';
import 'package:the_best_app/Utils/back_page_button.dart';
import 'package:the_best_app/Utils/legends.dart';
import 'package:the_best_app/Utils/radial_chart.dart';
import 'package:the_best_app/Functions/createchartdata.dart';
import 'package:the_best_app/Functions/dateFormatter.dart';
import 'package:the_best_app/Functions/elaborateDataFunctions.dart';
import 'package:the_best_app/Functions/findTarget.dart';
import 'package:the_best_app/models/targetTypes.dart';

class SummaryPage extends StatelessWidget {
  //ShoppingPage({Key? key}) : super(key: key);
  static const route =
      '/hellowordpage/loginpage/homepage/pointspage/summarypage';
  static const routename = 'Summary';
  final String username;

  SummaryPage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${SummaryPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        leading: Back_Page_withArgs(
            [10, 10, 5, 5], context, PointsPage.route, {'username': username}),
        title: Text(SummaryPage.routename),
        actions: [
          IconButton(
              // Questo bottone serve per avere le informazioni!!
              iconSize: 40,
              tooltip: 'Info',
              icon: Icon(Icons.question_mark_rounded),
              color: Colors.green[100],
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          content: SingleChildScrollView(
                              child: ListBody(children: [
                        FutureBuilder(
                            future: findTarget(context, username),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final target = snapshot.data as String;
                                final List values = Target().targets[target]!;

                                return Text(
                                    'Your target:\n${values[0]} steps\n${values[1]} calories\n${values[2]} minutes cardio\n${values[3]} hours sleep');
                              } else {
                                return Text('');
                              }
                            }),
                      ])));
                    });
              }),
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Here you can see a resume of your daily points',
                //textAlign: TextAlign.center,
                //style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 20),
              Legend_bar(),
              SizedBox(height: 10),
              Expanded(
                child:
                    Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
                  return FutureBuilder(
                      initialData: null,
                      future: Future.wait([
                        dbr.findAllFitbitDataUser(username),
                        findTarget(context, username)
                      ]),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data as List<Object>;
                          final fitbit = data[0] as List<myFitbitData>;
                          final target = data[1] as String;
                          final fitbit2 = fitbit.reversed.toList();
                          return Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                                itemCount: fitbit2.length,
                                itemBuilder: (_, index) {
                                  Text myText =
                                      Text('${myDate(fitbit2[index].keyDate)}');
                                  Text myText2 = Text(
                                      'Steps: ${fitbit2[index].steps}, Calories: ${fitbit2[index].calories}, Cardio: ${fitbit2[index].cardio},  Sleep: ${fitbit2[index].sleepHours}');
                                  final List<CircularStackEntry> chartData =
                                      createChartData(fitbit2[index], target);
                                  final todayPoints =
                                      elaboratePoints(fitbit2[index], target);
                                  final List values = Target().targets[target]!;
                                  //print(todayPoints);
                                  if (fitbit2[index].steps > values[0] &&
                                      fitbit2[index].calories > values[1] &&
                                      fitbit2[index].cardio > values[2] &&
                                      fitbit2[index].sleepHours > values[3]) {
                                    return Card(
                                      child: ListTile(
                                        isThreeLine: true,
                                        title: myText,
                                        subtitle: myText2,
                                        trailing: IconButton(
                                          icon: Icon(Icons.arrow_right),
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return myAlert(chartData,
                                                      todayPoints, myText.data);
                                                });
                                          },
                                        ),
                                      ),
                                      color: Colors.green[200],
                                    );
                                  } else {
                                    // Steps, calories, cardio, sleep
                                    final style =
                                        _ismissing(fitbit2[index], values);
                                    var myText3 = RichText(
                                        text: TextSpan(
                                            style:
                                                TextStyle(color: Colors.black),
                                            children: [
                                          TextSpan(
                                              text:
                                                  'Steps: ${fitbit2[index].steps}, ',
                                              style: style[0]),
                                          TextSpan(
                                              text:
                                                  'Calories: ${fitbit2[index].calories}, ',
                                              style: style[1]),
                                          TextSpan(
                                              text:
                                                  ' Cardio: ${fitbit2[index].cardio},  ',
                                              style: style[2]),
                                          TextSpan(
                                              text:
                                                  'Sleep: ${fitbit2[index].sleepHours}',
                                              style: style[3])
                                        ]));
                                    return Card(
                                        child: ListTile(
                                          isThreeLine: true,
                                          title: myText,
                                          subtitle: myText3,
                                          trailing: IconButton(
                                            icon: Icon(Icons.arrow_right),
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return myAlert(
                                                        chartData,
                                                        todayPoints,
                                                        myText.data);
                                                  });
                                            },
                                          ),
                                        ),
                                        color: Colors.red[50]);
                                  }
                                }),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      });
                }),
              ),
            ],
          )),
    );
  } //build

} //Page

String myDate(int date) {
  return dateFormatter(
      DateTime.fromMillisecondsSinceEpoch(date * Duration.millisecondsPerDay),
      opt: 2);
}

class myAlert extends StatelessWidget {
  final List<CircularStackEntry> chartData;
  final List<double> pointsData;
  final String? data;

  myAlert(this.chartData, this.pointsData, this.data);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      //This function will subtract points;
      title: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Text(
          'POINTS DETAIL\n$data',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Legend_rad())
      ]),
      titleTextStyle: TextStyle(color: Colors.black), //fontSize: 10),
      content: Container(
          child: RadialChart(chartData: chartData, pointsData: pointsData)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
    );
  }
}

List<dynamic> _ismissing(myFitbitData fitbit2, List values) {
  List output = [true, true, true, true];
  List style = [
    TextStyle(fontWeight: FontWeight.normal),
    TextStyle(fontWeight: FontWeight.normal),
    TextStyle(fontWeight: FontWeight.normal),
    TextStyle(fontWeight: FontWeight.normal)
  ];
  if (fitbit2.steps < values[0]) {
    output[0] = false;
    style[0] = TextStyle(fontWeight: FontWeight.w900, color: Colours.darkRed);
  }
  if (fitbit2.calories < values[1]) {
    output[1] = false;
    style[1] = TextStyle(fontWeight: FontWeight.w900, color: Colours.darkRed);
  }
  if (fitbit2.cardio < values[2]) {
    output[2] = false;
    style[2] = TextStyle(fontWeight: FontWeight.w900, color: Colours.darkRed);
  }
  if (fitbit2.sleepHours < values[3]) {
    output[3] = false;
    style[3] = TextStyle(fontWeight: FontWeight.w900, color: Colours.darkRed);
  }
  return style;
}
