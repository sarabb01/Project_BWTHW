import 'package:flutter/material.dart';
import 'package:the_best_app/screens/Rewards/queryPage.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PreferencePage extends StatelessWidget {
  PreferencePage({Key? key}) : super(key: key);

  static const route = '/preference';
  static const routename = 'Preference Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Rewards')),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Image.asset(
                  'assets/Images/picwish.png',
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'How would you like to spend your points?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18),
              ),
              Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                      children: [
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Ink.image(
                              image: AssetImage('assets/Images/shopping.png'),
                              child: InkWell(
                                onTap: () {
                                  String selection = 'shops';
                                  Navigator.pushNamed(context, QueryPage.route,
                                      arguments: selection);
                                },
                              ),
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.contain),
                          Text(
                            'Shopping',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Ink.image(
                              image: AssetImage('assets/Images/sports.png'),
                              child: InkWell(
                                onTap: () {
                                  String selection = 'experiences';
                                  Navigator.pushNamed(context, QueryPage.route,
                                      arguments: selection);
                                },
                              ),
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.contain),
                          Text(
                            'Experience',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20),
                          )
                        ],
                      ),
                    ),
                  ]))
            ],
          ),
        ));
  } //build

} //Page

