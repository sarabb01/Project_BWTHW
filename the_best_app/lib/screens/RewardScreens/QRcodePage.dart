// Flutter packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ffi';
import 'package:random_string/random_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Screens
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';

// Database
import 'package:the_best_app/Database/Entities/VouchersList.dart';
import 'package:the_best_app/Repository/database_repository.dart';

// Widgets and models
import 'package:the_best_app/Utils/back_page_button.dart';
import 'package:the_best_app/Utils/checkBoxWidget.dart';
import 'package:the_best_app/models/expList.dart';
import 'package:the_best_app/models/shopList.dart';

class QRcodePage extends StatelessWidget {
  int item; // ID Current Experience/Shop List
  Map list; // Current Experience/Shop Map
  QRcodePage({required this.item, required this.list});

  static const route =
      '/hellowordpage/loginpage/homepage/preferencepage/querypage/shoppingpage/voucherpage';
  static const routename = 'VOUCHER PAGE';

  @override
  Widget build(BuildContext context) {
    print('${QRcodePage.routename} built');
    final key = list.keys.elementAt(item); // Key (Experienxe/Shop Name)
    final place = list[key]![1]; // Experience/Shop Location
    final prize = list[key]![2]; // Experience/Shop Disconut Voucher
    final String web_code = randomAlphaNumeric(10).toUpperCase(); // Web Code
    return Scaffold(
        appBar: AppBar(
          leading: Back_Page([10, 10, 5, 5], context, PreferencePage.route),
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
                  web_code,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                insetAnimationDuration: Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0)),
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
                    child: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 30,
                    )),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    //This function will subtract points;
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Confirmation required',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: Text(
                                'After confirmation, the required points will be subtracted from your total score.\nYou will find your available vouchers in the Home page',
                                textAlign: TextAlign.center),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0)),
                            actions: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          final sp = await SharedPreferences
                                              .getInstance();

                                          final double spent_points =
                                              list[key]![0].toDouble();
                                          print(spent_points.runtimeType);
                                          final String s =
                                              sp.getString('username')! +
                                                  'SpentPoints';

                                          final prev_score =
                                              sp.getDouble(s) ?? 0.0;
                                          print(prev_score);
                                          sp.setDouble(
                                              s, prev_score + spent_points);
                                          print(sp.getDouble(s));

                                          final tot_points =
                                              sp.getDouble('Points');
                                          sp.setDouble('Points',
                                              tot_points! - spent_points);

                                          int userid = sp.getInt('userid')!;
                                          final voucher = VoucherList(
                                              null,
                                              userid,
                                              list[key]![2],
                                              key,
                                              list[key]![3],
                                              web_code,
                                              list[key]![4]);
                                          await Provider.of<UsersDatabaseRepo>(
                                                  context,
                                                  listen: false)
                                              .addUserVoucher(voucher);
                                          Navigator.pushReplacementNamed(
                                              context, HomePage.route,
                                              arguments: {
                                                'username':
                                                    sp.getString('username')!
                                              });
                                        }, // TO BE IMPLEMENTED
                                        icon: Icon(
                                          Icons.check_circle,
                                          color: Theme.of(context).primaryColor,
                                          size: 40,
                                        )),
                                    //},
                                    //),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.cancel_rounded,
                                          color: Colors.red,
                                          size: 40,
                                        )),
                                  ])
                            ],
                            actionsAlignment: MainAxisAlignment.center,
                          );
                        });
                  },
                  child: Text('Use voucher'),
                )
              ]),
        ));
  }
}
