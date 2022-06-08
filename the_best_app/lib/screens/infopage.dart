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
              'This application was thought to enhance sports made by users, to do this we decided to allow to the users to fix some target and once these targets get reached the users can obtain an award. This award can be a coupon ready to be used for a discount in a shop, chosen from a list, or ready to be used for an experience related to your preference. Obviously if you decide to gain your coupon you will choose the shop from the ones near your city.',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(
            width: 30,
            height: 30,
          ),
          FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, Homepage.route);
              },
              child: Icon(Icons.done))
        ],
      ),
    );
  } //build

} //Page