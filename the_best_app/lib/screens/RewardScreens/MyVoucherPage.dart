import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:colours/colours.dart';
import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Database/Entities/VouchersList.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Utils/back_page_button.dart';

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
        body: Center(
          child:
              Consumer<UsersDatabaseRepo>(builder: (context, voucher, child) {
            return FutureBuilder(
                initialData: null,
                future: get_userid(),
                builder: (context, user) {
                  if (user.hasData) {
                    final userid = user.data as int;
                    return FutureBuilder(
                        initialData: null,
                        future: voucher.findAllUserVouchers(userid),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final data = snapshot.data as List<VoucherList>;
                            if (data.length == 0) {
                              return Center(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                  side: BorderSide(
                                                      color: Colours.seaGreen)),
                                            ),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.all(5)),
                                            backgroundColor:
                                                MaterialStateProperty.all(Colours
                                                    .seaGreen), // <-- Button color
                                            overlayColor: MaterialStateProperty
                                                .resolveWith<Color?>((states) {
                                              if (states.contains(
                                                  MaterialState.pressed))
                                                return Colors
                                                    .red; // <-- Splash color
                                            })),
                                        onPressed: () {
                                          Navigator.pushReplacementNamed(
                                              context, PreferencePage.route);
                                        },
                                        child: Text(
                                          'No Vouchers Yet',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CircularProgressIndicator(
                                      strokeWidth: 10,
                                    )
                                  ]));
                            } else {
                              return Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GridView.builder(
                                      itemCount: data.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.landscape
                                            ? 3
                                            : 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 8,
                                      ),
                                      itemBuilder: (context, i) {
                                        return InkWell(
                                          child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              color: Colours.lightSalmon,
                                              elevation: 5,
                                              child: Center(
                                                child: Padding(
                                                    padding: EdgeInsets.all(10),
                                                    child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            '${data[i].shop_name.toUpperCase()}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 15),
                                                          ),
                                                          Text(
                                                            '${data[i].discount}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 13),
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Image.asset(
                                                            data[i]
                                                                .front_image_path,
                                                            scale: 6,
                                                          ),
                                                        ])),
                                              )),
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      backgroundColor:
                                                          Colours.antiqueWhite,
                                                      title: Text(
                                                          '${data[i].shop_name} Coupon',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          )),
                                                      content: Container(
                                                          width:
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1.2,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                          child: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(15),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Coupon Code :  ${data[i].discount_code}",
                                                                        textAlign:
                                                                            TextAlign
                                                                                .center,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                        )),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Image.asset(
                                                                      data[i]
                                                                          .QRcode_path,
                                                                      scale: 2,
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          ElevatedButton(
                                                                            style: ButtonStyle(
                                                                                elevation: MaterialStateProperty.all(0),
                                                                                shape: MaterialStateProperty.all(CircleBorder()),
                                                                                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                                                                                backgroundColor: MaterialStateProperty.all(Colours.lightSalmon), // <-- Button color
                                                                                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                                                                  if (states.contains(MaterialState.pressed)) return Colors.white38; // <-- Splash color
                                                                                })),
                                                                            child: Padding(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.check,
                                                                                      color: Colors.blue,
                                                                                    ),
                                                                                    Text(
                                                                                      'Use',
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 10,
                                                                                      ),
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                            onPressed:
                                                                                () async {
                                                                              await voucher.deleteUserVoucher(data[i]);
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                15,
                                                                          ),
                                                                          ElevatedButton(
                                                                            style: ButtonStyle(
                                                                                elevation: MaterialStateProperty.all(0),
                                                                                shape: MaterialStateProperty.all(CircleBorder()),
                                                                                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                                                                                backgroundColor: MaterialStateProperty.all(Colours.lightSalmon), // <-- Button color
                                                                                overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                                                                                  if (states.contains(MaterialState.pressed)) return Colors.white38; // <-- Splash color
                                                                                })),
                                                                            child: Padding(
                                                                                padding: EdgeInsets.all(10),
                                                                                child: Column(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.first_page,
                                                                                      color: Colors.red,
                                                                                    ),
                                                                                    Text(
                                                                                      'Back',
                                                                                      style: TextStyle(
                                                                                        color: Colors.black,
                                                                                        fontWeight: FontWeight.bold,
                                                                                        fontSize: 10,
                                                                                      ),
                                                                                      textAlign: TextAlign.center,
                                                                                    )
                                                                                  ],
                                                                                )),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                          ),
                                                                        ])
                                                                  ]))));
                                                });
                                          },
                                        );
                                      }));
                            }
                          } else {
                            return CircularProgressIndicator(
                              strokeWidth: 10,
                            );
                          }
                        });
                  } else {
                    return Center(
                        child: Column(children: [
                      ElevatedButton(
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colours.seaGreen)),
                              ),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(5)),
                              backgroundColor: MaterialStateProperty.all(
                                  Colours.seaGreen), // <-- Button color
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (states) {
                                if (states.contains(MaterialState.pressed))
                                  return Colors.red; // <-- Splash color
                              })),
                          onPressed: () {},
                          child: Text(
                            '!! Something Gone Wrong !!',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      CircularProgressIndicator(
                        strokeWidth: 10,
                      )
                    ]));
                  }
                });
          }),
        ));
  }

  Future<int?> get_userid() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getInt('userid');
  }
}
