// Packages
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Registration and Login Screens
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/LoginScreens/ForgotPasswordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/RegistrationPage.dart';

// Home, Profile, Info Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/PointsScreens/fitbitAuthPage.dart';
import 'package:the_best_app/Screens/HomeScreens/infoPage2.dart';
import 'package:the_best_app/Screens/HomeScreens/infoPage.dart';
import 'package:the_best_app/Screens/HomeScreens/profilePage.dart';

// Points and Reward Screens
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Screens/RewardScreens/queryPage.dart';
import 'package:the_best_app/Screens/RewardScreens/shoppingPage.dart';
import 'package:the_best_app/Screens/RewardScreens/experiencePage.dart';
import 'package:the_best_app/Screens/RewardScreens/QRcodePage.dart';
import 'package:the_best_app/Screens/RewardScreens/MyVoucherPage.dart';
import 'package:the_best_app/Screens/PointsScreens/summaryPage.dart';
import 'package:the_best_app/Screens/PointsScreens/pointsPage.dart';

// Database
import 'package:the_best_app/Database/database.dart';
import 'package:the_best_app/Repository/database_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //This opens the database.
  final AppDatabase database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final users_database_repo = UsersDatabaseRepo(database: database);

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
            scaffoldBackgroundColor: Colours.green[50],
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
            return MaterialPageRoute(builder: (context) {
              return HomePage();
            });
          } else if (settings.name == RegistrationPage.route) {
            return MaterialPageRoute(builder: (context) {
              return RegistrationPage();
            });
          } else if (settings.name == ForgotPasswordPage.route) {
            return MaterialPageRoute(builder: (context) {
              return ForgotPasswordPage();
            });
          } else if (settings.name == Infopage.route) {
            return MaterialPageRoute(builder: (context) {
              return Infopage();
            });
          } else if (settings.name == AuthPage.route) {
            return MaterialPageRoute(builder: (context) {
              return AuthPage();
            });
          } else if (settings.name == Profilepage.route) {
            return MaterialPageRoute(builder: (context) {
              return Profilepage();
            });
            // } else if (settings.name == FetchPage.route) {
            //   return MaterialPageRoute(builder: (context) {
            //     return FetchPage();
            //   });
          } else if (settings.name == PointsPage.route) {
            final args6 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return PointsPage(username: args6['username']);
            });
          } else if (settings.name == SummaryPage.route) {
            final args7 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return SummaryPage(username: args7['username']);
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
            final args3 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return ShoppingPage(
                city: args3['city'],
                earnedPoints: args3['points'],
              );
            });
          } else if (settings.name == ExperiencePage.route) {
            final args4 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return ExperiencePage(
                city: args4['city'],
                earnedPoints: args4['points'],
              );
            });
          } else if (settings.name == QRcodePage.route) {
            final args5 = settings.arguments as Map;
            return MaterialPageRoute(builder: (context) {
              return QRcodePage(
                item: args5['n'],
                list: args5['type'],
              );
            });
          } else if (settings.name == MyVoucherPage.route) {
            return MaterialPageRoute(builder: (context) {
              return MyVoucherPage();
            });
          } else if (settings.name == InfoPage2.route) {
            return MaterialPageRoute(builder: (context) {
              return InfoPage2();
            });
          } else {
            return null;
          }
        });
  } //build
} //MyApp
