import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_project/screens/preferencesPage.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'Home Page';

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(HomePage.routename),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, PrefPage.route);
            },
            child: Text('Hello, world!'),
          ),
        ));
  } //build

} //Page
