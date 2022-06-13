import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_best_app/Utils/points_displayer.dart';
import 'package:the_best_app/models/expList.dart';
import 'package:the_best_app/screens/RewardScreens/QRcodePage.dart';

class ExperiencePage extends StatelessWidget {
  // ExperiencePage({Key? key}) : super(key: key);

  static const route =
      '/hellowordpage/loginpage/homepage/preferencepage/querypage/experience';
  static const routename = 'Experiences';

  String city;
  double earnedPoints;
  ExperiencePage({required this.city, required this.earnedPoints});

  final expList explist = expList();
  //final earnedPoints = 0;

  @override
  Widget build(BuildContext context) {
    //final word = ModalRoute.of(context)!.settings.arguments! as String;
    print('${ExperiencePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(ExperiencePage.routename),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here you can see the list of experiences near "$city" that you can buy with your points',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Only eligible locations are active',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Center(child: Points_displayer()),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: explist.Catalog.length,
                    itemBuilder: (_, index) {
                      String key = explist.Catalog.keys.elementAt(index);
                      return earnedPoints >= explist.Catalog[key]![0]
                          ? Card(
                              child: ListTile(
                                  isThreeLine: true,
                                  title: Text(key),
                                  subtitle: Text(
                                      'Location: ${explist.Catalog[key]![1]}\nRequired points : ${explist.Catalog[key]![0]}'),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.arrowRight),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, QRcodePage.route,
                                          arguments: {
                                            'n': index,
                                            'type': explist.Catalog
                                          });
                                    },
                                  )),
                            )
                          : Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                  isThreeLine: true,
                                  title: Text(key,
                                      style: TextStyle(color: Colors.grey)),
                                  subtitle: Text(
                                      'Location: ${explist.Catalog[key]![1]}\nRequired points : ${explist.Catalog[key]![0]}')),
                            );
                    }),
              )
            ],
          )),
    );
  } //build

} //Page

