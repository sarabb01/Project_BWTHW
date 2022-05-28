import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class QRcodePage extends StatelessWidget {
  QRcodePage({Key? key}) : super(key: key);

  static const route = '/qr';
  static const routename = 'QR CODE PAGE';
  @override
  Widget build(BuildContext context) {
    print('${QRcodePage.routename} built');
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: Image.asset(
                    'assets/Images/qrimge.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  randomAlphaNumeric(10),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 20),
                Text(
                    'Physical store: scan the QR code \nWebsite: use the numerical code',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontSize: 20))
              ]),
        ));
  }
}
