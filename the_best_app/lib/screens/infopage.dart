import 'package:flutter/material.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';

class Infopage extends StatelessWidget {
  Infopage({Key? key}) : super(key: key);

  static const route = '/hellowordpage/registrationpage/Infopage';
  static const routename = 'Infopage';

  @override
  Widget build(BuildContext context) {
    print('${Infopage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(Infopage.routename),
      ),
      body: Center(
          child: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 45, 25, 5),
          child: Column(children: [
            Text(
              'This application is thought to encourage you to maintain a healthy lifestyle and keep yourself fit by doing some sport activity and having the necessary rest.\n\nThe better you perform, in terms of number of steps, burnt calories, minutes in active heart ratio range and duration of sleep, the higher score you will be given.\n\nYour points will sum up day-by-day and you will be given the possibility to get a reward proportional to you effort!\n\nThe reward can be a voucher to get a discount by some affiliated shops or associations offering sport experiences.\n\nYou can also decide just to set your own target and to put effort into reaching it as soon as possible.',
              style: TextStyle(fontSize: 16),
              //textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
                'In order to calculate your daily points we need to have access to your Fitbit account.\nPlease, LOG IN in Fitbit')
          ]),
        ),
        // SizedBox(
        //   width: 30,
        //   height: 30,
        // ),
      ])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, LoginPage.route);
            // Navigator.pushNamed(context, HomePage.route,
            //     arguments: {'username': 'Pippo'});
          },
          child: Icon(Icons.done)),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
    );
  } //build

} //Page