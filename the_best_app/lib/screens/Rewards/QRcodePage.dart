import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:the_best_app/models/expList.dart';
import 'package:the_best_app/models/shopList.dart';

class QRcodePage extends StatelessWidget {
  //QRcodePage({Key? key}) : super(key: key);
  int item;
  Map list;
  QRcodePage({required this.item, required this.list});

  static const route = '/qr';
  static const routename = 'QR CODE PAGE';

  @override
  Widget build(BuildContext context) {
    print('${QRcodePage.routename} built');
    final key = list.keys.elementAt(item);
    final place = list[key]![1];
    final prize = list[key]![2];
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'CONGRATULATIONS!\nYou won $prize at "$place"\nUse the code below to get your reward!',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontSize: 20)),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: Image.asset(
                    'assets/Images/qrimge.png',
                    fit: BoxFit.contain,
                  ),
                ),
                //SizedBox(height: 8),
                Text(
                  randomAlphaNumeric(10),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                SizedBox(height: 10),
                Text(
                    'Physical store: scan the QR code \nWebsite: use the numerical code',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontSize: 15))
              ]),
        ));
  }
}
