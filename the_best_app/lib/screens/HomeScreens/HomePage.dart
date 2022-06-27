// APP SCREENS
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/infoPage2.dart';
import 'package:the_best_app/Screens/profilepage.dart';
import 'package:the_best_app/Screens/PointsScreens/fitbitAuthPage.dart';
import 'package:the_best_app/Screens/PointsScreens/pointsPage.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Screens/RewardScreens/MyVoucherPage.dart';

// FUNCTIONS
import 'package:the_best_app/functions/elaborateDataFunctions.dart';
import 'package:the_best_app/functions/findTarget.dart';

// FLUTTER PACKAGES
import 'package:flutter/cupertino.dart';
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
// DATABASE
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/FitbitTables.dart';

// SE NON FUNZIONA, COMMIT 6268fb4845e60975d2fb92c6f3126a3076201e8b

class HomePage extends StatefulWidget {
  static const route = '/hellowordpage/loginpage/homepage';
  static const routename = 'Homepage';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController
      controller; // per controllare animazione di circular progress indicator, ho messo late perchè inizializzo dopo la variabile
  //double puntiottenuti = 70; //puntiottenuti ricavati da conversione punti
  double obiettivo = 300; //obiettivo fissato pagina preference
  String username = 'SOMETHING GONE WRONG';
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    controller.repeat();
    SharedPreferences.getInstance().then((res) {
      setState(() {
        // Return string of "useFullName"
        // or return empty string if "userFullName" is null
        username = res.getString("username")!;
        print('1 $username');
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void user_name(String username) async {
    final sp = await SharedPreferences.getInstance();
    String name = sp.getString('username')!;
    username = name.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    print('${HomePage.routename} built');
    // _loadPoints();
    return Scaffold(
        appBar: AppBar(
          title: username == null || username.isEmpty
              ? Text('ERROR !! (No Username Found)',
                  style: TextStyle(fontWeight: FontWeight.bold))
              : Text(username.toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            // IconButton(
            //     icon: Icon(Icons.show_chart_outlined),
            //     onPressed: () {
            //       Navigator.pushNamed(context, AuthPage.route);
            //     })
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: Text(
                  'Settings',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colours.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    'Personal Area',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  trailing: Icon(Icons.account_circle),
                  tileColor: Colors.green[100],
                  onTap: () {
                    Navigator.pushReplacementNamed(context, Profilepage.route);
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    'My Vouchers',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  trailing: Icon(Icons.favorite),
                  tileColor: Colors.green[100],
                  onTap: () {
                    Navigator.pushReplacementNamed(
                        context, MyVoucherPage.route);
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: Text(
                      "Log-Out",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    tileColor: Colors.green[100],
                    trailing: Icon(Icons.logout),
                    onTap: () async {
                      final sp = await SharedPreferences.getInstance();
                      sp.remove('username');
                      sp.remove('userid');
                      Navigator.pushReplacementNamed(context, LoginPage.route);
                    }),
              ),
              Padding(
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 10),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      // side: BorderSide(color: Colours.azure)
                    ),
                    title: Text(
                      'Info',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                    trailing: Icon(Icons.info_outline),
                    tileColor: Colors.green[100],
                    onTap: () {
                      Navigator.pushNamed(context, InfoPage2.route);
                    },
                  )),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              List<myFitbitData> allData =
                                                  await Provider.of<
                                                              UsersDatabaseRepo>(
                                                          context,
                                                          listen: false)
                                                      .findAllFitbitData();
                                              print(
                                                  'Days to delete ${allData.length}');
                                              await Provider.of<
                                                          UsersDatabaseRepo>(
                                                      context,
                                                      listen: false)
                                                  .deleteAllFitbitData(allData);
                                              Navigator.pop(context);
                                            }, // TO BE IMPLEMENTED
                                            icon: Icon(
                                              Icons.check_circle,
                                              color: Theme.of(context)
                                                  .primaryColor,
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
                    }),
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    'Manage your authorization',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                  trailing: Icon(Icons.key_rounded),
                  tileColor: Colors.green[100],
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AuthPage.route);
                  },
                ),
              ),
            ],
          ),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center,
              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.2,
                  height: MediaQuery.of(context).size.height / 6,
                  child: Image.asset('assets/Images/logoblack.png',
                      fit: BoxFit.contain),
                  //decoration:
                  //BoxDecoration(border: Border.all(color: Colors.black)),
                ),
                SizedBox(height: 20),
                const Text(
                  'Points earned:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onDoubleTap: () async {
                    final sp = await SharedPreferences.getInstance();
                    Navigator.pushNamed(context, PointsPage.route,
                        arguments: {'username': sp.getString('username')});
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Colours.paleTurquoise,
                        shape: BoxShape.circle,
                      ),
                      width: 200,
                      height: 200,
                      child: FutureBuilder(
                          //child: Consumer<PointsModel>(
                          future: SharedPreferences.getInstance(),

                          // Provider.of<UsersDatabaseRepo>(context, listen: false)
                          //     .findAllFitbitDataUser(username),
                          // findTarget(context, username)

                          builder: (context, snapshot) {
                            //builder: (context, score, child) {
                            if (snapshot.hasData) {
                              // final data = snapshot.data as List<Object>;
                              final result = snapshot.data as SharedPreferences;
                              final String? user = result.getString('username');
                              print('sp user: ${user}');

                              return FutureBuilder(
                                  future: Future.wait([
                                    SharedPreferences.getInstance(),
                                    Provider.of<UsersDatabaseRepo>(context,
                                            listen: false)
                                        .findAllFitbitDataUser(username),
                                    // Provider.of<UsersDatabaseRepo>(context,
                                    //     listen: false)
                                    // .findAllFitbitDataUser(result.getString('username')!)

                                    findTarget(context, username)
                                  ]),
                                  builder: (context, snapshot) {
                                    //builder: (context, score, child) {
                                    if (snapshot.hasData) {
                                      final data =
                                          snapshot.data as List<Object>;
                                      final result =
                                          data[0] as SharedPreferences;
                                      final check =
                                          data[1] as List<myFitbitData>;
                                      final target = data[2]
                                          as String; // check the username is correct
                                      print('Data length ${check.length}');
                                      print(
                                          'Target $target'); // check is he/she has some points stored

                                      final double tot = check.length != 0
                                          ? computeTotalPoints(check, target)
                                          : 0.0; // get all the points
                                      final spent_points = check.length != 0 &&
                                              result.getDouble('SpentPoints') !=
                                                  null
                                          ? result.getDouble('SpentPoints')
                                          : 0.0; // get the spent points
                                      result.setDouble(
                                          'Points',
                                          tot -
                                              spent_points!); // set the new points variable
                                      if (result.getDouble('Points') != null) {
                                        final score = result
                                            .getDouble('Points')!
                                            .roundToDouble(); // set the variable used for the graph
                                        //print('points: ${result.getDouble('Points')}');
                                        return Stack(
                                          fit: StackFit.expand,
                                          children: [
                                            CircularProgressIndicator(
                                              value: score / obiettivo,
                                              //value: score.totalScore / obiettivo,
                                              backgroundColor: Colors.grey[400],
                                              color: Colours.mediumSeaGreen,
                                              strokeWidth: 25,
                                            ),
                                            Center(
                                              child: buildprogress(score),
                                              //child: buildprogress(score.totalScore),
                                            ),
                                          ],
                                        );
                                      } else {
                                        final score = 0.0;
                                        return EmptyCircle(score);
                                      }
                                    } else {
                                      final score = 0.0;
                                      return EmptyCircle(score);
                                      // return CircularProgressIndicator();
                                    }
                                  });
                            } else {
                              final score = 0.0;
                              return EmptyCircle(score);
                              // return CircularProgressIndicator();
                            }
                          })),
                ),
                SizedBox(height: 40),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colours.mediumSeaGreen,
                      textStyle: TextStyle(color: Colors.white),
                      padding: EdgeInsets.only(
                          top: 5, left: 10, bottom: 5, right: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(color: Colours.mediumSeaGreen)),
                    ),
                    child: Text(
                      'CLAIM YOUR REWARD',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, PreferencePage.route);
                    }),
                // CupertinoButton.filled(
                //     child: const Text('Gain your Award'),
                //     borderRadius: BorderRadius.circular(25.0),
                //     onPressed: () {
                //       Navigator.pushNamed(context, PreferencePage.route);
                //     }),
                Container(
                  //width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height / 6,
                  child: Image.asset(
                    'assets/Images/present.png',
                    fit: BoxFit.cover,
                  ),
                )
              ]),
        )));
  } //build

  Widget EmptyCircle(double score) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CircularProgressIndicator(
          value: score / obiettivo,
          backgroundColor: Colors.grey[400],
          color: Colours.mediumSeaGreen,
          strokeWidth: 25,
        ),
        Center(
          child: buildprogress(score),
        ),
      ],
    );
  }

  Widget buildprogress(double score) {
    if (score / obiettivo >= 1) {
      return Container(
        width: 120,
        height: 120,
        child: Column(children: [
          Text(
            'Well done!\nTarget reached!',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15),
          ),
          const Icon(Icons.done, color: Colors.green, size: 56),
          Text(
            '${(score)}' '/' '${(obiettivo).toStringAsFixed(0)}',
            style: TextStyle(fontSize: 15),
          )
        ]),
      );
    } else {
      return Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 120,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  border: Border.all(color: Colors.green, width: 3),
                  borderRadius: BorderRadius.circular(20)),
              alignment: Alignment.center,
              child: Text(
                '${(score)}' '/' '${(obiettivo).toStringAsFixed(0)}',
                style: TextStyle(fontSize: 20),
              )),
          SizedBox(height: 5),
          Text('Double tap for details')
        ]),
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
