// Packages
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Login Screens
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/LoginScreens/ForgotPasswordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/RegistrationPage.dart';
// Home Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/screens/PointsScreens/fetchPage.dart';
import 'package:the_best_app/screens/PointsScreens/fitbitAuthPage.dart';
// User Database
import 'package:the_best_app/Database/database.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/screens/PointsScreens/pointsPage.dart';
// Rewards Screens
import 'package:the_best_app/screens/Rewards/selectPrefPage.dart';
import 'package:the_best_app/screens/Rewards/queryPage.dart';
import 'package:the_best_app/screens/Rewards/shoppingPage.dart';
import 'package:the_best_app/screens/Rewards/experiencePage.dart';
import 'package:the_best_app/screens/Rewards/QRcodePage.dart';

Future<void> main() async {
  //This is a special method that use WidgetFlutterBinding to interact with the Flutter engine.
  //This is needed when you need to interact with the native core of the app.
  //Here, we need it since when need to initialize the DB before running the app.
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  //This creates a new DatabaseRepository from the AppDatabase instance just initialized
  final users_database_repo = UsersDatabaseRepo(database: database);
  //Here, we run the app and we provide to the whole widget tree the instance of the DatabaseRepository.
  //That instance will be then shared through the platform and will be unique.
  runApp(ChangeNotifierProvider<UsersDatabaseRepo>(
    create: (context) => users_database_repo,
    child: MyApp(),
  ));
} //main

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            scaffoldBackgroundColor: Colours.green[100],
            primarySwatch: Colours.seaGreen),
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
          } else if (settings.name == AuthPage.route) {
            return MaterialPageRoute(builder: (context) {
              return AuthPage();
            });
          } else if (settings.name == FetchPage.route) {
            return MaterialPageRoute(builder: (context) {
              return FetchPage();
            });
          } else if (settings.name == PointsPage.route) {
            return MaterialPageRoute(builder: (context) {
              return PointsPage();
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
} //MyApp
