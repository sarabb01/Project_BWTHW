import 'package:floor/floor.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_best_app/Utils/formats.dart';

class PointsPage extends StatelessWidget {
  // final Map input;
  static const route = '/points';
  static const routename = 'Points Page';

  // PointsPage({Key? key, required this.input})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final input = ModalRoute.of(context)!.settings.arguments! as Map;
    print('${PointsPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(PointsPage.routename),
          actions: [
            IconButton(
                onPressed: () async {
                  List<SleepData> allSleepData =
                      await Provider.of<UsersDatabaseRepo>(context,
                              listen: false)
                          .findAllSleepData();
                  print(allSleepData.length);
                  // for (int j = 0; j < alldata.length; j++) {
                  await Provider.of<UsersDatabaseRepo>(context, listen: false)
                      .deleteAllSleepData(allSleepData);
                  // }
                },
                icon: Icon(Icons.delete))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.smart_toy_outlined),
          onPressed: () async {
            List<SleepData> allSleepData =
                await Provider.of<UsersDatabaseRepo>(context, listen: false)
                    .findAllSleepData();
            int totalHours = 0;
            for (int k = 0; k < allSleepData.length; k++) {
              totalHours += allSleepData[k].sleepHours;
            }
            print(totalHours);
          },
        ),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text('TODAY\'S POINTS'),
              Text('TOTAL POINTS'),
              Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
                return FutureBuilder(
                    initialData: null,
                    future: Future.wait([
                      dbr.findAllSleepData(),
                      dbr.findAllActivityData(),
                      dbr.findAllStepsData(),
                      dbr.findAllHeartData(),
                      dbr.findAllFitbitData()
                    ]),
                    //future: dbr.findAllSleepData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final data = snapshot.data as List<List<Object>>;
                        final sleep = data[0] as List<SleepData>;
                        final calories = data[1] as List<ActivityData>;
                        final steps = data[2] as List<StepsData>;
                        final heart = data[3] as List<HeartData>;
                        final fitbit = data[4] as List<myFitbitData>;

                        final List total = [
                          ['Sleep', computeSum1(sleep)],
                          ['Calories', computeSum2(calories)],
                          ['Steps', computeSum3(steps)],
                          ['Minutes Cardio', computeSum4(heart)]
                        ];
                        return sleep.length == 0
                            ? Text('The list is currently empty')
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: fitbit.length,
                                  //itemCount: total.length,
                                  itemBuilder: (context, index) {
                                    //String key = input.keys.elementAt(index);
                                    return Card(
                                        elevation: 3,
                                        child: ListTile(
                                          leading: Icon(MdiIcons.note),
                                          title: Text('${fitbit[index].date}'),
                                          subtitle: Text(
                                              'Sleep: ${fitbit[index].sleepHours}'),
                                          // title: Text(
                                          //     '${total[index][0]} (${data[index].length})'),
                                          // subtitle: Text('${total[index][1]}'),

                                          // onTap: () async {
                                          //   await Provider.of<DatabaseRepository>(
                                          //           context,
                                          //           listen: false)
                                          //       .deleteSleepData(data[index]);
                                          // }
                                        ));
                                  },
                                ),
                              );
                      } else {
                        return CircularProgressIndicator();
                      }
                    }
                    // child: ListView.builder(
                    //     itemCount: input.length,
                    //     itemBuilder: (context, index) {
                    //       String key = input.keys.elementAt(index);
                    //       return Card(
                    //           elevation: 3,
                    //           child: ListTile(
                    //             leading: Icon(MdiIcons.note),
                    //             title: Text('${input[key]}'),
                    //             subtitle: Text(key),
                    //           ));
                    //     }),
                    );
              }),
            ])));
  } //build

} //Page

int computeSum1(List<SleepData> input) {
  int tot = 0;
  for (int k = 0; k < input.length; k++) {
    tot += input[0].sleepHours;
  }
  return tot;
}

int computeSum2(List<ActivityData> input) {
  int tot = 0;
  for (int k = 0; k < input.length; k++) {
    tot += input[0].calories;
  }
  return tot;
}

int computeSum3(List<StepsData> input) {
  int tot = 0;
  for (int k = 0; k < input.length; k++) {
    tot += input[0].steps;
  }
  return tot;
}

int computeSum4(List<HeartData> input) {
  int tot = 0;
  for (int k = 0; k < input.length; k++) {
    tot += input[0].cardio;
  }
  return tot;
}
