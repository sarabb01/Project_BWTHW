// Flutter packages
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Screens/RewardScreens/QRcodePage.dart';

// Database
import 'package:the_best_app/Database/Entities/VouchersList.dart';
import 'package:the_best_app/Repository/database_repository.dart';

// Widgets and models
import 'package:the_best_app/Utils/back_page_button.dart';
import 'package:the_best_app/Utils/points_displayer.dart';
import 'package:the_best_app/models/expList.dart';

class ExperiencePage extends StatelessWidget {
  static const route =
      '/hellowordpage/loginpage/homepage/preferencepage/querypage/experience';
  static const routename = 'Experiences';

  String city;
  double earnedPoints;
  ExperiencePage({required this.city, required this.earnedPoints});

  final expList explist = expList();

  @override
  Widget build(BuildContext context) {
    print('${ExperiencePage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(ExperiencePage.routename),
        leading: Back_Page([10, 10, 5, 5], context, PreferencePage.route),
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

} //ExperiencePage

