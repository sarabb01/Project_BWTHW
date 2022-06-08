// APP SCREENS
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/screens/PointsScreens/fitbitAuthPage.dart';
import 'package:the_best_app/screens/Rewards/selectPrefPage.dart';
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
import 'package:the_best_app/screens/infopage.dart';
import 'package:the_best_app/screens/profilepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/hellowordpage/loginpage/homepage';
  static const routename = 'Homepage';

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController
      controller; // per controllare animazione di circular progress indicator, ho messo late perchè inizializzo dopo la variabile
  double puntiottenuti = 7000; //puntiottenuti ricavati da conversione punti
  double obiettivo = 10000; //obiettivo fissato pagina preference

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
    print('${Homepage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: const Text(Homepage.routename),
          actions: [
            FloatingActionButton(
                child: Icon(Icons.info),
                onPressed: () {
                  Navigator.pop(context, Infopage.route);
                })
          ],
        ),
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
                'My Voucher',
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
                'Delete my points',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              trailing: Icon(Icons.remove),
              tileColor: Colors.green[100],
              onTap: () async {
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              const Text(
                'Points for the AWARD :',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: puntiottenuti / obiettivo,
                      backgroundColor: Colors.grey,
                      color: Colours.darkSeagreen,
                      strokeWidth: 25,
                    ),
                    Center(
                      child: buildprogress(),
                    ),
                  ],
                ),
              ),
              //Text(
              //'You are far'
              //' ${(obiettivo - puntiottenuti)}'
              //' points from the AWARD, GO AND GET IT',
              //style: TextStyle(fontSize: 20),
              //)
              CupertinoButton.filled(
                  child: const Text('Gain your Award'),
                  onPressed: () {
                    //Navigator.pushNamed(context, /preferencePage)
                  })
            ])));
  } //build

  Widget buildprogress() {
    if (puntiottenuti / obiettivo == 1) {
      return const Icon(Icons.done, color: Colors.green, size: 56);
    } else {
      return Text(
        '${(puntiottenuti)}' '/' '${(obiettivo).toStringAsFixed(1)}',
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
