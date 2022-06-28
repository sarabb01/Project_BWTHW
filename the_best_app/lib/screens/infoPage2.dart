import 'package:flutter/material.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Utils/back_page_button.dart';

class InfoPage2 extends StatelessWidget {
  InfoPage2({Key? key}) : super(key: key);

  static const route =
      '/hellowordpage/registrationpage/loginpage/homepage/infopage2';
  static const routename = 'Infopage2';

  @override
  Widget build(BuildContext context) {
    print('${InfoPage2.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text('Info about MOVE(te)'),
        leading: Back_Page([10, 10, 5, 5], context, HomePage.route),
      ),
      body: SingleChildScrollView(
        child: Center(
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
                'We have also thought about three different target, which allow you to obtain points and when you register in the app you can choose between them; they are :\n1) Basic : 7 hours of sleep per night, 600 calories burned per day, 10 minutes of cardio per day, 10000 steps per day ;     \n2) Medium : 7 hours of sleep per day, 800 calories burned per day, 15 minutes of cardio per day, 12000 steps per day;   \n3) Advanced : 7 hours of sleep per day, 1000 calories burned per day, 20 minutes of cardioper day, 15000 steps per day.',
                style: TextStyle(fontSize: 16),
              )
            ]),
          ),
          // SizedBox(
          //   width: 30,
          //   height: 30,
          // ),
        ])),
      ),
    );
  } //build

} //Page