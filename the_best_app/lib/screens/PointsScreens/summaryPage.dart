import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/functions/dateFormatter.dart';

class SummaryPage extends StatelessWidget {
  //ShoppingPage({Key? key}) : super(key: key);
  static const route =
      '/hellowordpage/loginpage/homepage/pointspage/summarypage';
  static const routename = 'Summary';

  SummaryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${SummaryPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(SummaryPage.routename),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here you can see a resume of your daily points',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 20),
              Expanded(
                child:
                    Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
                  return FutureBuilder(
                      initialData: null,
                      future: dbr.findAllFitbitData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final fitbit = snapshot.data as List<myFitbitData>;
                          final fitbit2 = fitbit.reversed.toList();
                          return Scrollbar(
                            isAlwaysShown: true,
                            child: ListView.builder(
                                itemCount: fitbit2.length,
                                itemBuilder: (_, index) {
                                  if (fitbit2[index].steps > 10000 &&
                                      fitbit2[index].calories > 600 &&
                                      fitbit2[index].cardio > 15 &&
                                      fitbit2[index].sleepHours > 7) {
                                    return Card(
                                      child: ListTile(
                                        isThreeLine: true,
                                        title: Text(
                                            '${myDate(fitbit2[index].keyDate)}'),
                                        subtitle: Text(
                                            'Steps: ${fitbit2[index].steps}, Calories: ${fitbit2[index].calories}, Cardio: ${fitbit2[index].cardio},  Sleep: ${fitbit2[index].sleepHours}'),
                                      ),
                                      color: Colors.green[200],
                                    );
                                  } else {
                                    return Card(
                                      child: ListTile(
                                        isThreeLine: true,
                                        title: Text(
                                            '${myDate(fitbit2[index].keyDate)}'),
                                        subtitle: Text(
                                            'Steps: ${fitbit2[index].steps}, Calories: ${fitbit2[index].calories}, Cardio: ${fitbit2[index].cardio},  Sleep: ${fitbit2[index].sleepHours}'),
                                      ),
                                      color: Colors.red[100],
                                    );
                                  }
                                  ;
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
