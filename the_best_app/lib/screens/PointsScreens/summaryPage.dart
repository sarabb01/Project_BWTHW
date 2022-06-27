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
import 'package:the_best_app/functions/createchartdata.dart';
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/functions/elaborateDataFunctions.dart';
import 'package:the_best_app/functions/findTarget.dart';
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
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here you can see a resume of your daily points',
                //style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 20),
              Legend_bar(),
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
        Legend_rad()
      ]),
      titleTextStyle: TextStyle(color: Colors.black), //fontSize: 10),
      content: Container(
          child: RadialChart(chartData: chartData, pointsData: pointsData)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
    );
  }
}
