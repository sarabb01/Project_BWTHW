// Flutter packages
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'package:the_best_app/Screens/RewardScreens/experiencePage.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Screens/RewardScreens/shoppingPage.dart';

// Widgets
import 'package:the_best_app/Utils/back_page_button.dart';

class QueryPage extends StatelessWidget {
  static const route =
      '/hellowordpage/loginpage/homepage/preferencepage/querypage/';
  static const routename = 'Query';
  final myController = TextEditingController();

  String path;

  QueryPage({required this.path});

  @override
  Widget build(BuildContext context) {
    print('${QueryPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
        leading: Back_Page([10, 10, 5, 5], context, PreferencePage.route),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_on, color: Colors.green),
                      labelText: 'Insert Location',
                      border: UnderlineInputBorder()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      final sp = await SharedPreferences.getInstance();
                      double score = sp.getDouble('Points') ?? 0;
                      if (myController.text != '' && path == 'shops') {
                        Navigator.pushNamed(context, ShoppingPage.route,
                            arguments: {
                              'city': myController.text,
                              'points': score
                            });
                      } else if (myController.text != '' &&
                          path == 'experiences') {
                        Navigator.pushNamed(context, ExperiencePage.route,
                            arguments: {
                              'city': myController.text,
                              'points': score
                            });
                      } else if (myController.text == '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('LOCATION MISSING!')));
                      } else {
                        print('Error!');
                      }
                      ;
                    },
                    child: Text('Search')),
                SizedBox(height: 20),
                Text(
                  'Look for the available $path close to your position',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
              ],
            )),
      ),
    );
  } //build

} //QueryPage

