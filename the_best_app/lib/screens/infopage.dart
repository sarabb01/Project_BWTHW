import 'package:flutter/material.dart';
import 'package:the_best_app/screens/HomeScreens/HomePage.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: const Text(
              'This application is thought to encourage you to maintain a healthy lifestyle and keep yourself fit by doing some sport activity, but also by having the necessary rest.\nThe better you perform, in terms of number of steps, burnt calories, minutes in active heart ratio range and duration of sleep, the higher score you will be given.\nYour points will sum up day-by-day and you will be given the possibility to get a reward proportional to you effort!\nThe reward can be a voucher to get a discount by some affiliated sport shops or affiliated organizations that offer sport experiences.\nYou can also decide to just set your own target and to put effort into reaching it as soon as possible',
              style: TextStyle(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
          ),
          FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.route,
                    arguments: {'username': 'Pippo'});
              },
              child: Icon(Icons.done))
        ],
      ),
    );
  } //build

} //Page