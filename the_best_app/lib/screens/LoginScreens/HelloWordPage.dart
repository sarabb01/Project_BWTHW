import 'package:flutter/material.dart';
import 'LoginPage.dart';
import 'RegistrationPage.dart';

class HelloWordPage extends StatelessWidget {
  static const route = '/hellowordpage';
  static const routename = 'Welcome Page';
  @override
  Widget build(BuildContext context) {
    print('${HelloWordPage.routename} built');
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            routename,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
              child: Center(
                child: Image.asset(
                  'assets/Images/flutter-logo.png',
                  width: screenSize.width / 1.5,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 10),
              child: Text(
                'Say Hello To Your New App!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            WelcomePage_Form(screenSize, 'Log In', context, LoginPage.route),
            WelcomePage_Form(
                screenSize, 'Sign In', context, RegistrationPage.route)
          ],
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
          primary: Colors.blueAccent,
          textStyle: TextStyle(color: Colors.white),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: BorderSide(color: Colors.blueAccent)),
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
