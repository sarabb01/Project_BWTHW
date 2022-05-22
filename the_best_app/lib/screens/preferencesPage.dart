import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_project/screens/experiencePage.dart';
import 'package:prova_project/screens/shoppingPage.dart';
// https://github.com/afgprogrammer/Flutter-GridView-Example-UI/blob/master/lib/main.dart

class PrefPage extends StatelessWidget {
  PrefPage({Key? key}) : super(key: key);

  static const route = '/pref';
  static const routename = 'Preference Page';

  @override
  Widget build(BuildContext context) {
    print('${PrefPage.routename} built');
    return Scaffold(
        appBar: AppBar(
            //title: Text('Favourites'),
            ),
        body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 250,
                  //decoration: BoxDecoration(),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Where would you like to spend your points?',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center),
                          SizedBox(height: 60),
                          Text("Make your choice",
                              style: TextStyle(
                                  //color: Colors.grey[900],
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                          // Container(
                          //   height: 20,
                          //   margin: EdgeInsets.symmetric(horizontal: 100),
                          //   decoration: BoxDecoration(
                          //       //borderRadius: BorderRadius.circular(10),
                          //       color: Colors.white),
                          //   child: Center(
                          //       child:),
                          // ),
                          SizedBox(height: 30),
                        ]),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      //padding: EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        Card(
                            color: Colors.greenAccent[400],
                            elevation: 2,
                            child:
                                // opzione A
                                // Container(
                                //   decoration: BoxDecoration(
                                //     borderRadius: BorderRadius.circular(20),
                                //     // image: DecorationImage(
                                //     //     image: AssetImage('assets\one.jpg'),
                                //     //     fit: BoxFit.cover)
                                //   ),
                                //   child: Container(
                                //     margin: EdgeInsets.symmetric(
                                //         horizontal: 10, vertical: 10),
                                //     child: ListTile(
                                //       title: Text('Shopping',
                                //           style: TextStyle(
                                //             fontSize: 20,
                                //             fontStyle: FontStyle.italic,
                                //           )),
                                //       onTap: () {
                                //         Navigator.pushNamed(
                                //             context, Opt1Page.route);
                                //       },
                                //     ),
                                //   ),
                                // )

                                //OPZIONE B
                                Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                  Text('Shopping',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic)),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                            context, Opt1Page.route);
                                      },
                                      icon: Icon(MdiIcons.shoppingOutline),
                                      iconSize: 50)
                                ])),
                        Card(
                          color: Colors.greenAccent[400],
                          elevation: 1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('Experiences',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic)),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, Opt2Page.route);
                                    },
                                    icon: Icon(
                                      IconData(0xf7ed,
                                          fontFamily: 'MaterialIcons'),
                                    ),
                                    iconSize: 50)
                              ]),
                        )
                      ]),
                )
              ],
            ),
          ),
        )
        //],
        );
  } //build

} //Page
