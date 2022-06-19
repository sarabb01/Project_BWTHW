// APP SCREENS
import 'package:the_best_app/Database/Entities/FitbitTables.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/models/pointsModel.dart';
import 'package:the_best_app/screens/PointsScreens/fitbitAuthPage.dart';
import 'package:the_best_app/screens/PointsScreens/pointsPage.dart';
import 'package:the_best_app/screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/screens/infopage.dart';
// FLUTTER PACKAGES
import 'package:flutter/cupertino.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// DATABASE
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/screens/profilepage.dart';

class HomePage extends StatefulWidget {
  static const route = '/hellowordpage/loginpage/homepage';
  static const routename = 'Homepage';

  String username;

  HomePage({required this.username});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController
      controller; // per controllare animazione di circular progress indicator, ho messo late perchè inizializzo dopo la variabile
  //double puntiottenuti = 70; //puntiottenuti ricavati da conversione punti
  double obiettivo = 300; //obiettivo fissato pagina preference

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    // _loadPoints();
    return Scaffold(
        appBar: AppBar(
          title: widget.username == null || widget.username.isEmpty
              ? Text('ERROR !! (No username)',
                  style: TextStyle(fontWeight: FontWeight.bold))
              : Text(widget.username.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            Row(
              children: [
                IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      Navigator.pushNamed(context, Infopage.route);
                    }),
                IconButton(
                    icon: Icon(Icons.show_chart_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, AuthPage.route);
                    })
              ],
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              final sp = await SharedPreferences.getInstance();
              if (sp.getDouble('Points') != null) {
                double? score = sp.getDouble('Points');
                print(score);
              }
            },
            child: Icon(Icons.update)),
        drawer: Drawer(
            child: ListView(children: [
          Padding(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              child: Container(
                //decoration: BoxDecoration(
                //color: Theme.of(context).accentColor,
                //),
                //child:
                // Center(
                child: Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colours.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              )),
          //),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                //side: BorderSide(color: Colours.azure)
              ),
              title: Text(
                'Personal Area',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.account_circle),
              tileColor: Colors.green[100],
              onTap: () {
                Navigator.pushNamed(context, Profilepage.route);
                //Navigator.pushNamed(context, PreferencePage.route);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: BorderSide(color: Colours.azure)
              ),
              title: Text(
                'My Vouchers',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.more_vert),
              tileColor: Colors.green[100],
              onTap: () async {
                //await remove_Profile(widget.username, context);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, top: 400, bottom: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: BorderSide(color: Colours.azure)
              ),
              title: Text(
                'Delete all points',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.remove),
              tileColor: Colors.green[100],
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: Text('Confirmation required'),
                          content: Text(
                              'WARNING!\nIf you continue, all your progress will be deleted and you will have to start again from zero!\nDo you want to proceed?'),
                          //color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
                          actions: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        List<myFitbitData> allData =
                                            await Provider.of<
                                                        UsersDatabaseRepo>(
                                                    context,
                                                    listen: false)
                                                .findAllFitbitData();
                                        print(allData.length);
                                        await Provider.of<UsersDatabaseRepo>(
                                                context,
                                                listen: false)
                                            .deleteAllFitbitData(allData);
                                        Navigator.pop(context);
                                      }, // TO BE IMPLEMENTED
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
                          actionsAlignment: MainAxisAlignment.center);
                    });
                //await remove_Profile(widget.username, context);
              },
            ),
          ),
          //BottomNavigationBar(items: const <BottomNavigationBarItem>[
          //BottomNavigationBarItem(
          //icon: Icons.remove_circle,
          //label: Text('Delete my Profile')),
          //])
        ])),
        body: Center(
            //TweenAnimationBuilder(
            //tween: Tween(begin: 0.0, end: 1.0),
            //duration: Duration(seconds: 10),
            //builder: (context, value, _) =>
            child: Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: Image.asset('assets/Images/logoblack.png',
                      fit: BoxFit.contain),
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                ),
                SizedBox(height: 50),
                const Text(
                  'Your points:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 40),
                GestureDetector(
                  onDoubleTap: () {
                    Navigator.pushNamed(context, PointsPage.route);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      width: 200,
                      height: 200,
                      //child: FutureBuilder()
                      child: Consumer<PointsModel>(
                        //future: SharedPreferences.getInstance(),
                        builder: (context, score, child) {
                          //if (snapshot.hasData) {
                          //final result = snapshot.data as SharedPreferences;
                          //if (result.getDouble('Points') != null) {
                          //final score = result.getDouble('Points');
                          //final score = score.
                          return Stack(
                            fit: StackFit.expand,
                            children: [
                              CircularProgressIndicator(
                                value: score.totalScore / obiettivo,
                                backgroundColor: Colors.grey[400],
                                color: Colors.greenAccent[700],
                                strokeWidth: 25,
                              ),
                              Center(
                                child: buildprogress(score.totalScore),
                              ),
                            ],
                          );
                          //   } else {
                          //     final score = 0.0;
                          //     return Stack(
                          //       fit: StackFit.expand,
                          //       children: [
                          //         CircularProgressIndicator(
                          //           value: score / obiettivo,
                          //           backgroundColor: Colors.grey[400],
                          //           color: Colors.greenAccent[700],
                          //           strokeWidth: 25,
                          //         ),
                          //         Center(
                          //           child: buildprogress(score),
                          //         ),
                          //       ],
                          //     );
                          //   }
                          // } else {
                          //   return CircularProgressIndicator();
                          // }
                        },
                      )),
                ),
                //Text(
                //'You are far'
                //' ${(obiettivo - puntiottenuti)}'
                //' points from the AWARD, GO AND GET IT',
                //style: TextStyle(fontSize: 20),
                //),
                SizedBox(height: 80),
                CupertinoButton.filled(
                    child: const Text('Gain your Award'),
                    onPressed: () {
                      Navigator.pushNamed(context, PreferencePage.route);
                    })
              ]),
        )));
  } //build

  Widget buildprogress(double score) {
    if (score / obiettivo == 1) {
      return const Icon(Icons.done, color: Colors.green, size: 56);
    } else {
      return Text(
        '${(score)}' '/' '${(obiettivo).toStringAsFixed(0)}',
        style: TextStyle(fontSize: 20),
      );
    }
  }
} //Homepage

//Future<void> remove_Profile(String username, BuildContext context) async {
//final user = await Provider.of<UsersDatabaseRepo>(context, listen: false)
// .findUser(username);
// Before deleting the current profile we check if is currently logged in and if is correctly signed in the database
//if (user != null) {
//final sp = await SharedPreferences.getInstance();
//await sp.remove('username'); // Updating current Login session
//await Provider.of<UsersDatabaseRepo>(context, listen: false)
//.deleteUser(user); // Deleting User Profile
//await Navigator.pushReplacementNamed(context, HelloWordPage.route);
//}
//}
