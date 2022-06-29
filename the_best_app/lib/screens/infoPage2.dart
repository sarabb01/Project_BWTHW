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
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 80),
            child: Column(children: [
              Text(
                'This application is thought to encourage you to maintain a healthy lifestyle and keep yourself fit by doing some sport activity and having the necessary rest.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                //textAlign: TextAlign.center,
              ),
              Text(
                  '\nThe better you perform, in terms of number of steps, burnt calories, minutes in active heart ratio range and duration of sleep, the higher score you will be given.\n\nYour points will sum up day-by-day and you will be given the possibility to get a reward proportional to you effort!\n',
                  style: TextStyle(fontSize: 16)),
              Text(
                  'The reward can be a voucher to get a discount by some affiliated shops or associations offering sport experiences.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(
                height: 20,
              ),
              Text(
                'You can choose among three different targets, depending on your training levels:',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '\n1) Basic : 7 hours of sleep per night, 600 calories burned per day, 10 minutes of cardio per day, 10000 steps per day;\n2) Medium : 7 hours of sleep per night, 800 calories burned per day, 15 minutes of cardio per day, 12000 steps per day;\n3) Advanced : 7 hours of sleep per night, 1000 calories burned per day, 20 minutes of cardio per day, 15000 steps per day\n',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'The higher the target, the faster you will get lots of points!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
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