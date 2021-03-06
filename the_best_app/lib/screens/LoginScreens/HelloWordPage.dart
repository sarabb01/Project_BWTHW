// Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/HomeScreens/infoPage.dart';
import 'LoginPage.dart';
import 'RegistrationPage.dart';
// Database
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
// Flutter Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:colours/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelloWordPage extends StatefulWidget {
  static const route = '/hellowordpage';
  static const routename = 'Welcome Page';

  @override
  State<HelloWordPage> createState() => _HelloWordPageState();
}

class _HelloWordPageState extends State<HelloWordPage> {
  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null) {
      //If 'username is set, push the HomePage
      Navigator.pushReplacementNamed(context, HomePage.route,
          arguments: {'username': sp.getString('username')});
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${HelloWordPage.routename} built');
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            HelloWordPage.routename,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 20, right: 20),
                child: Center(
                  child: Image.asset(
                    'assets/Images/logoblack.png',
                    width: screenSize.width / 1.2,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
                child: Text(
                  'Welcome!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              WelcomePage_Form(screenSize, 'Log In', context, LoginPage.route),
              WelcomePage_Form(
                  screenSize, 'Sign In', context, RegistrationPage.route),
              Padding(
                padding:
                    EdgeInsets.only(left: 40, top: 150, right: 40, bottom: 40),
                child: Column(children: [
                  Text(
                    'Before getting started you should know something more about this app, so click the button below',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colours.mediumSeaGreen),
                      onPressed: () {
                        Navigator.pushNamed(context, Infopage.route);
                      },
                      child: Icon(
                        Icons.info,
                      ))
                ]),
              ),
            ],
          )),
        ),
        drawer: Drawer(
            elevation: 5,
            child: Center(
              child:
                  Consumer<UsersDatabaseRepo>(builder: (context, dbr, child) {
                return FutureBuilder(
                  future: dbr.findAllUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final data = snapshot.data as List<UsersCredentials>;
                      //If the Meal table is empty, show a simple Text, otherwise show the list of meals using a ListView.
                      return data.length == 0
                          ? ElevatedButton(
                              child: Text('No Users Registered Yet',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, i) {
                                return Card(
                                  elevation: 5,
                                  child: ListTile(
                                    leading: Icon(MdiIcons.account),
                                    title: Text(
                                      'Username : ${data[i].username}',
                                      textAlign: TextAlign.start,
                                    ),
                                    subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Automatic ID : ${data[i].id}',
                                              textAlign: TextAlign.center),
                                          Text(
                                              'Password  : ${data[i].password}',
                                              textAlign: TextAlign.center)
                                        ]),
                                  ),
                                );
                              });
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                );
              }),
            )));
  }
}

Widget WelcomePage_Form(
    screenSize, String text, BuildContext context, String route) {
  return Padding(
    padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20),
    child: Container(
      width: screenSize.width / 1.5,
      height: screenSize.height / 15,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colours.mediumSeaGreen,
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.only(top: 5, bottom: 5),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colours.mediumSeaGreen)),
        ),
        child: Text(
          text,
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
      ),
    ),
  );
}
