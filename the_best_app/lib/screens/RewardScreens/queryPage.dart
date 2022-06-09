import 'package:flutter/material.dart';
import 'package:the_best_app/screens/RewardScreens/experiencePage.dart';
import 'package:the_best_app/screens/RewardScreens/shoppingPage.dart';

class QueryPage extends StatelessWidget {
  //QueryPage({Key? key}) : super(key: key);

  static const route = '/preference/query';
  static const routename = 'Query';
  final myController = TextEditingController();

  String path;

  QueryPage({required this.path});

  @override
  Widget build(BuildContext context) {
    print('${QueryPage.routename} built');
    //final path = ModalRoute.of(context)!.settings.arguments! as String;
    //print(ModalRoute.of(context)!.settings.arguments!);
    return Scaffold(
      appBar: AppBar(title: Text('Search')),
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
                    onPressed: () {
                      if (myController.text != '' && path == 'shops') {
                        Navigator.pushNamed(context, ShoppingPage.route,
                            arguments: myController.text);
                      } else if (myController.text != '' &&
                          path == 'experiences') {
                        Navigator.pushNamed(context, ExperiencePage.route,
                            arguments: myController.text);
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

} //Page
