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
                  // List<SleepData> alldata =
                  //     await Provider.of<UsersDatabaseRepo>(context,
                  //             listen: false)
                  //         .findAllSleepData();
                  // print(alldata.length);
                  // for (int j = 0; j < alldata.length; j++) {
                  //   await Provider.of<UsersDatabaseRepo>(context,
                  //           listen: false)
                  //       .deleteSleepData(alldata[j]);
                  // }
                },
                icon: Icon(Icons.delete))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.smart_toy_outlined),
          onPressed: () async {
            List<SleepData> alldata =
                await Provider.of<UsersDatabaseRepo>(context, listen: false)
                    .findAllSleepData();
            int totalHours = 0;
            for (int k = 0; k < alldata.length; k++) {
              totalHours += alldata[k].sleepHours;
            }
            print(totalHours);
          },
        ),
        body: Center(
            child: Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
          return FutureBuilder(
              initialData: null,
              future: dbr.findAllSleepData(),
              //future: dbr.findAllSleepData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data as List<SleepData>;
                  return data.length == 0
                      ? Text('The list is currently empty')
                      : ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            //String key = input.keys.elementAt(index);
                            return Card(
                                elevation: 3,
                                child: ListTile(
                                  leading: Icon(MdiIcons.note),
                                  title: Text('${data[index].sleepHours}'),
                                  subtitle: Text(
                                      '${Formats.fullDateFormatNoSeconds.format(data[index].date)}'),
                                  // onTap: () async {
                                  //   await Provider.of<DatabaseRepository>(
                                  //           context,
                                  //           listen: false)
                                  //       .deleteSleepData(data[index]);
                                  // }
                                ));
                          });
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
        })));
  } //build

} //Page
