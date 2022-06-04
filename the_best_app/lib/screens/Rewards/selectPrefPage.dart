import 'package:flutter/material.dart';
import 'package:the_best_app/Utils/cardWidget.dart';
import 'package:the_best_app/screens/Rewards/queryPage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PreferencePage extends StatelessWidget {
  PreferencePage({Key? key}) : super(key: key);

  static const route = '/preference';
  static const routename = 'Preference Page';

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    //print(screenSize.width); // Width = 392; Height = 781
    return Scaffold(
      appBar: AppBar(title: Text('Rewards')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              //width: MediaQuery.of(context).size.width * 0.4,
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
            ),
            SizedBox(height: 50),
            Expanded(
                child: GridView.count(crossAxisCount: 2, crossAxisSpacing: 8,
                    //mainAxisSpacing: 4,
                    children: [
                  cardWidget(context, AssetImage('assets/Images/shopping.png'),
                      'Shopping', 'shops'),
                  cardWidget(context, AssetImage('assets/Images/sports.png'),
                      'Experience', 'experiences')
                ]))
          ],
        ),
      ),
    );
  } //build

} //Page
