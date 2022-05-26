import 'package:flutter/material.dart';
//LoginScreens
import 'package:prova_project/Screens/LoginScreens/LoginPage.dart';
import 'package:prova_project/Screens/LoginScreens/ForgotPasswordPage.dart';
import 'package:prova_project/Screens/LoginScreens/HelloWordPage.dart';
import 'package:prova_project/Screens/LoginScreens/RegistrationPage.dart';
// HomeScreens
import 'package:prova_project/Screens/HomeScreens/HomePage.dart';
// User Database
import 'package:prova_project/Database/user_cred_database.dart';
import 'package:prova_project/Repository/database_repository.dart';
// Otger Screens
import 'package:prova_project/Screens/experiencePage.dart';
import 'package:prova_project/Screens/preferencesPage.dart';
import 'package:prova_project/Screens/shoppingPage.dart';
import 'package:provider/provider.dart';
//TODO: import the homepage widget

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
} //MyApp
