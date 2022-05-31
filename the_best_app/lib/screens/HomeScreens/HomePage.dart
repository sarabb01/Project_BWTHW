// APP SCREENS
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/screens/Rewards/selectPrefPage.dart';
// FLUTTER PACKAGES
import 'package:flutter/cupertino.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// DATABASE
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';

class HomePage extends StatefulWidget {
  static const route = '/hellowordpage/loginpage/homepage';
  static const routename = 'HomePage';
  String username;

  HomePage({required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  double puntiraccolti = 5000;
  double obiettivo = 10000;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    return Scaffold(
        appBar: AppBar(
            title: widget.username == null || widget.username.isEmpty
                ? Text('ERROR !! (No username)',
                    style: TextStyle(fontWeight: FontWeight.bold))
                : Text(widget.username.toUpperCase(),
                    style: TextStyle(fontWeight: FontWeight.bold)),
            actions: [
              Back_Page([5, 5, 5, 5], context),
            ]),
        drawer: Drawer(
            child: ListView(children: [
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
            child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                ),
                child: Center(
                  child: Text(
                    'Drawer Header',
                    style: TextStyle(color: Colours.black),
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colours.fireBrick)),
              title: Text(
                'Remove Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              tileColor: Colours.fireBrick,
              onTap: () async {
                await remove_Profile(widget.username, context);
              },
            ),
          )
        ])),
        body: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Text('Punti raccolti : $puntiraccolti  obiettivo : $obiettivo '),
              SizedBox(
                child: CircularProgressIndicator(
                  value: puntiraccolti / obiettivo,
                  backgroundColor: Colors.grey,
                  color: Colours.darkSeagreen,
                  strokeWidth: 25.0,
                ),
                height: 150,
                width: 150,
              ),
              CupertinoButton.filled(
                  child: const Text('Gain Coupon'), onPressed: () {}),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Personal_Area_Form([5, 5, 5, 5], context),
                    SizedBox(height: 30),
                  ]),
                  SizedBox(
                    width: 10,
                  ),
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Points_Area_Form([5, 5, 5, 5], context),
                    SizedBox(height: 30),
                  ]),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ])));
  }
}

Widget Back_Page(List<double> edge_insets, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(
        left: edge_insets[0],
        top: edge_insets[1],
        right: edge_insets[2],
        bottom: edge_insets[3],
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(5)),
              backgroundColor: MaterialStateProperty.all(
                  Colours.darkSeagreen), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.red; // <-- Splash color
              })),
          onPressed: (() async {
            final sp = await SharedPreferences.getInstance();
            sp.remove('username');
            Navigator.pushReplacementNamed(context, LoginPage.route);
          }),
          child: Icon(
            Icons.first_page,
            color: Colors.black,
            size: 30,
          )));
}

Widget Personal_Area_Form(List<double> edge_insets, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(
        left: edge_insets[0],
        top: edge_insets[1],
        right: edge_insets[2],
        bottom: edge_insets[3],
      ),
      child: Container(
          width: 150,
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.lightBlue)),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blue), // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.red; // <-- Splash color
                  })),
              onPressed: (() {
                //Navigator.pushNamed(context, ProfilePage.route);
              }),
              child: Padding(
                  padding:
                      EdgeInsets.only(right: 5, bottom: 5, left: 5, top: 5),
                  child: Column(
                    children: [
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        'Personal Area',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  )))));
}

Widget Points_Area_Form(List<double> edge_insets, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(
        left: edge_insets[0],
        top: edge_insets[1],
        right: edge_insets[2],
        bottom: edge_insets[3],
      ),
      child: Container(
          width: 150,
          child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.orange)),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  backgroundColor: MaterialStateProperty.all(
                      Colors.orange), // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.red; // <-- Splash color
                  })),
              onPressed: (() {
                Navigator.pushNamed(context, PreferencePage.route);
              }),
              child: Padding(
                  padding:
                      EdgeInsets.only(right: 5, bottom: 5, left: 5, top: 5),
                  child: Column(
                    children: [
                      Icon(
                        MdiIcons.medal,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        'Awards',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  )))));
}

Future<void> remove_Profile(String username, BuildContext context) async {
  final user = await Provider.of<UsersDatabaseRepo>(context, listen: false)
      .findUser(username);
  // Before deleting the current profile we check if is currently logged in and if is correctly signed in the database
  if (user != null) {
    final sp = await SharedPreferences.getInstance();
    await sp.remove('username'); // Updating current Login session
    await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .deleteUser(user); // Deleting User Profile
    await Navigator.pushReplacementNamed(context, HelloWordPage.route);
  }
}
