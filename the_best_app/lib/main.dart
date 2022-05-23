import 'package:flutter/material.dart';
//LoginScreens
import 'package:prova_project/Screens/LoginScreens/LoginPage.dart';
import 'package:prova_project/Screens/LoginScreens/ForgotPasswordPage.dart';
import 'package:prova_project/Screens/LoginScreens/HelloWordPage.dart';
import 'package:prova_project/Screens/LoginScreens/RegistrationPage.dart';
// HomeScreens
import 'package:prova_project/Screens/HomeScreens/HomePage.dart';

import 'package:prova_project/Screens/experiencePage.dart';
import 'package:prova_project/Screens/preferencesPage.dart';
import 'package:prova_project/Screens/shoppingPage.dart';
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
        initialRoute: HelloWordPage.route,
        onGenerateRoute: (settings) {
          if (settings.name == HelloWordPage.route) {
            return MaterialPageRoute(builder: (context) {
              return HelloWordPage();
            });
          } else if (settings.name == LoginPage.route) {
            return MaterialPageRoute(builder: (context) {
              return LoginPage();
            });
          } else if (settings.name == HomePage.route) {
            final args1 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return HomePage(
                username: args1['username'],
              );
            });
          } else if (settings.name == RegistrationPage.route) {
            return MaterialPageRoute(builder: (context) {
              return RegistrationPage();
            });
          } else if (settings.name == ForgotPasswordPage.route) {
            return MaterialPageRoute(builder: (context) {
              return ForgotPasswordPage();
            });
          } else if (settings.name == Opt2Page.route) {
            return MaterialPageRoute(builder: (context) {
              return Opt2Page();
            });
          } else if (settings.name == Opt1Page.route) {
            return MaterialPageRoute(builder: (context) {
              return Opt1Page();
            });
          } else if (settings.name == PrefPage.route) {
            return MaterialPageRoute(builder: (context) {
              return PrefPage();
            });
          } else {
            return null;
          }
        });
  } //build
}//MyApp