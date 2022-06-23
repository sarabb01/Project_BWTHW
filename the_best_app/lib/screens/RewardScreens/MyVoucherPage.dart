import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:colours/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';

class MyVoucherPage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/homepage/myvoucherpage';
  static const routename = 'My Vouchers ';
  @override
  Widget build(BuildContext contest) {
    print('${MyVoucherPage.routename} Built');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          MyVoucherPage.routename,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Back_Page([10, 5, 5, 5], contest, HomePage.route),
      ),
      body: Center(child: Text('GridViwe usign Future Builder')),
    );
  }

  Widget Back_Page(
      List<double> edge_insets, BuildContext context, String pageroute) {
    return Padding(
        padding: EdgeInsets.only(
            left: edge_insets[0],
            right: edge_insets[1],
            bottom: edge_insets[2],
            top: edge_insets[3]),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                backgroundColor: MaterialStateProperty.all(
                    Colours.darkSeagreen), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                })),
            onPressed: (() {
              Navigator.pushReplacementNamed(context, pageroute);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
