// Flutter packages
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/RewardScreens/queryPage.dart';

// Widgets
import 'package:the_best_app/Utils/back_page_button.dart';
import 'package:the_best_app/Utils/cardWidget.dart';
import 'package:the_best_app/Utils/points_displayer.dart';

class PreferencePage extends StatelessWidget {
  PreferencePage({Key? key}) : super(key: key);

  static const route = 'helloworld/login/homepage/preference';
  static const routename = 'Preference Page';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    //print(screenSize.width); // Width = 392; Height = 781
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose your reward'),
        leading: Back_Page([10, 10, 5, 5], context, HomePage.route),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Points_displayer(),
            SizedBox(height: 20),
            Container(
              height: screenSize.height / 5,
              child: Image.asset(
                'assets/Images/picwish.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 25),
            Text(
              'How would you like to spend your points?',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    children: [
                  cardWidget(context, 'assets/Images/shopping.png', 'Shopping',
                      'shops'),
                  cardWidget(context, 'assets/Images/sports.png', 'Experience',
                      'experiences')
                ]))
          ],
        ),
      ),
    );
  } //build

} //PreferencePage
