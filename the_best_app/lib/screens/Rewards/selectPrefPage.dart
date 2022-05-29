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
          padding: const EdgeInsets.fromLTRB(5, 100, 5, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //width: MediaQuery.of(context).size.width * 0.4,
                height: 150, //MediaQuery.of(context).size.height * 0.3,
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
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 1,
                      children: [
                    Container(
                      //height: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Ink.image(
                              image: AssetImage('assets/Images/shopping.png'),
                              height:
                                  150, //MediaQuery.of(context).size.height * 0.4,
                              width:
                                  200, //MediaQuery.of(context).size.width * 0.4,
                              child: InkWell(
                                onTap: () {
                                  String selection = 'shops';
                                  Navigator.pushNamed(context, QueryPage.route,
                                      arguments: selection);
                                },
                              ),
                              fit: BoxFit.cover),
                          Text(
                            'Shopping',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          )
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 3),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        //alignment: Alignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                              height:
                                  150, //MediaQuery.of(context).size.height * 0.4,
                              width:
                                  200, //MediaQuery.of(context).size.width * 0.5,
                              fit: BoxFit.cover),
                          Text(
                            'Experience',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                //color: Colors.white,
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

