import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:the_best_app/Utils/checkBoxWidget.dart';
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
        appBar: AppBar(
            // title: Text(''),
            // actions: [
            //   IconButton(
            //       icon: Icon(Icons.backspace_outlined),
            //       onPressed: () {
            //         Navigator.popUntil(
            //             context, ModalRoute.withName('/preference'));
            //       })
            // ],
            ),
        body: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('CONGRATULATIONS!\n',
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text('You won $prize at "$place"',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1, fontSize: 20)),
                Text('Use the code below to get your prize!',
                    style: TextStyle(height: 1.5, fontSize: 15)),
                SizedBox(height: 30),
                Container(
                  width: MediaQuery.of(context).size.width * 0.4, //156
                  height: MediaQuery.of(context).size.height * 0.2, // 156
                  child: Image.asset(
                    'assets/Images/qrimge.png',
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  randomAlphaNumeric(10),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                insetAnimationDuration: Duration(seconds: 2),
                                //color: Colors.grey[100],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
                                //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
                                child: Container(
                                  width: 200,
                                  height: 100,
                                  child: Center(
                                    child: Text(
                                        'Physical store: scan the QR code \nWebsite: use the numerical code',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            height: 1.5, fontSize: 15)),
                                  ),
                                ));
                          });
                    },
                    icon: Icon(
                      Icons.info,
                      color: Colors.grey,
                    )),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    //This function will subtract points;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Confirmation required'),
                            content: Text(
                                'After confirmation, the required points will be subtracted from your total score.\nYou will find your available vouchers in the Home page'),
                            //color: Colors.grey[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
                            actions: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () {}, // TO BE IMPLEMENTED
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Theme.of(context).primaryColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.cancel_rounded,
                                            color: Colors.red)),
                                  ])
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                          );
                        });
                  },
                  child: Text('Use voucher'),
                )
                //checkboxWidget(),
              ]),
        ));
  }
}
