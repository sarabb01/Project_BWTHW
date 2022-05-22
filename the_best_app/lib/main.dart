import 'package:flutter/material.dart';
import 'package:prova_project/screens/experiencePage.dart';
import 'package:prova_project/screens/homePage.dart';
import 'package:prova_project/screens/preferencesPage.dart';
import 'package:prova_project/screens/shoppingPage.dart';
//TODO: import the homepage widget

void main() {
  runApp(MyApp());
} //main

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.green[100],
          primarySwatch: Colors.green),
      initialRoute: HomePage.route,
      //This maps names to the set of routes within the app
      routes: {
        HomePage.route: (context) => HomePage(),
        PrefPage.route: (context) => PrefPage(),
        Opt1Page.route: (context) => Opt1Page(),
        Opt2Page.route: (context) => Opt2Page(),
      },
    );
  } //build
}//MyApp