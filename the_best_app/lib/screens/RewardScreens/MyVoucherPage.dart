import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:colours/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';

class MyVoucherPage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/homepage/myvoucherpage';
  static const routename = 'My Vouchers';
  @override
  Widget build(BuildContext contest) {
    return Scaffold(
        appBar: AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        MyVoucherPage.routename,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        Back_Page([5, 10, 5, 5], contest)
      ],
    ));
  }

  Widget Back_Page(List<double> edgeInsets, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 5),
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
              Navigator.pushReplacementNamed(context, HomePage.route);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
