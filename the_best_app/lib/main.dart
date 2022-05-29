import 'package:flutter/material.dart';
//LoginScreens
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/LoginScreens/ForgotPasswordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/RegistrationPage.dart';
// HomeScreens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';

// Rewards screens
import 'package:the_best_app/screens/Rewards/selectPrefPage.dart';
import 'package:the_best_app/screens/Rewards/queryPage.dart';
import 'package:the_best_app/screens/Rewards/shoppingPage.dart';
import 'package:the_best_app/screens/Rewards/experiencePage.dart';
import 'package:the_best_app/screens/Rewards/QRcodePage.dart';

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
          } else if (settings.name == PreferencePage.route) {
            return MaterialPageRoute(builder: (context) {
              return PreferencePage();
            });
          } else if (settings.name == QueryPage.route) {
            final args2 = settings.arguments as String;
            return MaterialPageRoute(builder: (context) {
              return QueryPage(path: args2);
            });
          } else if (settings.name == ShoppingPage.route) {
            final args3 = settings.arguments as String;
            return MaterialPageRoute(builder: (context) {
              return ShoppingPage(city: args3);
            });
          } else if (settings.name == ExperiencePage.route) {
            final args4 = settings.arguments as String;
            return MaterialPageRoute(builder: (context) {
              return ExperiencePage(city: args4);
            });
          } else if (settings.name == QRcodePage.route) {
            final args5 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return QRcodePage(
                item: args5['n'],
                list: args5['type'],
              );
            });
          } else {
            return null;
          }
        });
  } //build
}//MyApp