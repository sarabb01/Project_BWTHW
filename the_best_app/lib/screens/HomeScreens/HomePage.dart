import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:prova_project/Screens/LoginScreens/LoginPage.dart';
import 'package:prova_project/Screens/LoginScreens/HelloWordPage.dart';
import 'package:prova_project/screens/preferencesPage.dart';

class HomePage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/homepage';
  static const routename = 'HomePage';
  String username;

  HomePage({required this.username});

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: username == null || username.isEmpty
              ? Text('ERROR !! (No username)',
                  style: TextStyle(fontWeight: FontWeight.bold))
              : Text(username.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Back_Page([5, 10, 5, 5], context)
          ],
        ),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                Calendar_Area_Form([5, 5, 5, 5], context),
                SizedBox(height: 30),
              ]),
              SizedBox(
                width: 20,
              ),
            ],
          ),
        ));
  }
}

Widget Back_Page(List<double> edge_insets, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 5),
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all(CircleBorder()),
              padding: MaterialStateProperty.all(EdgeInsets.all(5)),
              backgroundColor:
                  MaterialStateProperty.all(Colors.lime), // <-- Button color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.red; // <-- Splash color
              })),
          onPressed: (() async {
            final sp = await SharedPreferences.getInstance();
            sp.remove('username');
            await Navigator.pushReplacementNamed(context, LoginPage.route);
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
          right: edge_insets[0],
          bottom: edge_insets[1],
          left: edge_insets[2],
          top: edge_insets[3]),
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )))));
}

Widget Calendar_Area_Form(List<double> edge_insets, BuildContext context) {
  return Padding(
      padding: EdgeInsets.only(
          right: edge_insets[0],
          bottom: edge_insets[1],
          left: edge_insets[2],
          top: edge_insets[3]),
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
                Navigator.pushNamed(context, PrefPage.route);
              }),
              child: Padding(
                  padding:
                      EdgeInsets.only(right: 5, bottom: 5, left: 5, top: 5),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                        size: 30,
                      ),
                      Text(
                        'Calendar',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  )))));
}
