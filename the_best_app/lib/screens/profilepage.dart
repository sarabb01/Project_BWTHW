import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Utils/back_page_button.dart';
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';

class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  static const route = '/helloworldpage/loginpage/homepage/profilepage';
  //static const route = '/profilepage';
  static const routename = 'Profilepage';

  @override
  Widget build(BuildContext context) {
    print('${Profilepage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(Profilepage.routename),
          leading: Back_Page([10, 10, 5, 5], context, HomePage.route),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Confirmation required'),
                        content: Text(
                            'WARNING!\nIf you continue, your account and all your data will be deleted.\nAre you sure to proceed?'),
                        //color: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        //margin: EdgeInsets.fromLTRB(50, 450, 50, 200),
                        actions: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    // yes
                                    onPressed: () async {
                                      final sp =
                                          await SharedPreferences.getInstance();
                                      final name = sp.getString('username');
                                      print(name);
                                      final result =
                                          await Provider.of<UsersDatabaseRepo>(
                                                  context,
                                                  listen: false)
                                              .findUser(name!);
                                      var _user = result!.username;
                                      print(_user);
                                      if (result != null) {
                                        sp.remove('username');
                                        final String s = _user + 'SpentPoints';
                                        print('To remove: ${sp.getDouble(s)}');
                                        sp.remove(s);
                                        await Provider.of<UsersDatabaseRepo>(
                                                context,
                                                listen: false)
                                            .deleteUser(result);
                                      }

                                      await Navigator.pushNamed(
                                          context, HelloWordPage.route);
                                    },
                                    icon: Icon(
                                      Icons.check_circle,
                                      color: Theme.of(context).primaryColor,
                                    )),
                                IconButton(
                                    // NO
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.cancel_rounded,
                                        color: Colors.red)),
                              ])
                        ],
                        actionsAlignment: MainAxisAlignment.center);
                  });
            },
            child: Icon(Icons.delete)),
        body: Center(
            child: SizedBox(

//OPTION A
                child: FutureBuilder(
                    future: SharedPreferences.getInstance(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final result = snapshot.data as SharedPreferences;
                        if (result.getString('username') != null) {
                          final user = result.getString('username');

                          return FutureBuilder(
                              future: Provider.of<UsersDatabaseRepo>(context,
                                      listen: false)
                                  .findUser(user!),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final info =
                                      snapshot.data as UsersCredentials;
                                  //print(info.id);

                                  return FutureBuilder(
                                      future: Provider.of<UsersDatabaseRepo>(
                                              context,
                                              listen: false)
                                          .checkUserInfos(info.id!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final data =
                                              snapshot.data as UserInfos;

                                          //print(data.name);
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Personal Data',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Expanded(
                                                    child: ListView(
                                                      children: <Widget>[
                                                        Card(
                                                          child: ListTile(
                                                            title: Text('Name'),
                                                            subtitle: Text(
                                                                '${data.name}'),
                                                          ),
                                                        ),
                                                        Card(
                                                          child: ListTile(
                                                            title:
                                                                Text('Surname'),
                                                            subtitle: Text(
                                                              '${data.surname}',
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          child: ListTile(
                                                            title: Text(
                                                                'Date of Birth'),
                                                            subtitle: Text(
                                                              '${dateFormatter(data.dateofbirth, opt: 2)}',
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          child: ListTile(
                                                            title:
                                                                Text('Gender'),
                                                            subtitle: Text(
                                                              '${data.gender}',
                                                            ),
                                                          ),
                                                        ),
                                                        Card(
                                                          child: ListTile(
                                                            title:
                                                                Text('Target'),
                                                            subtitle: Text(
                                                              '${data.usertarget}',
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                } else {
                                  return ListView(
                                    children: <Widget>[
                                      Card(
                                        child: ListTile(
                                          title: const Text('Personal Data'),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Name'),
                                          subtitle: Text(''),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Surname'),
                                          subtitle: Text(''),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Date of Birth'),
                                          subtitle: Text(''),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Gender'),
                                          subtitle: Text(''),
                                        ),
                                      ),
                                      Card(
                                        child: ListTile(
                                          title: Text('Target'),
                                          subtitle: Text(''),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                              });
                        } else {
                          return CircularProgressIndicator();
                        }
                      } else {
                        return CircularProgressIndicator();
                      }
                    })

// OPTION B
                // child: ListView(
                //   children: <Widget>[
                //     ListTile(
                //       title: const Text('Personal Data'),
                //     ),
                //     ListTile(
                //         title: Text('Name'),
                //         subtitle: TextField(
                //           obscureText: true,
                //           decoration: InputDecoration(
                //             border: OutlineInputBorder(),
                //             labelText: '',
                //           ),
                //         )),
                //     ListTile(
                //       title: Text('Surname'),
                //       subtitle: TextField(
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: '',
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       title: Text('Sex'),
                //       subtitle: TextField(
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: '',
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       title: Text('Height'),
                //       subtitle: TextField(
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: '',
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       title: Text('Weight'),
                //       subtitle: TextField(
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: '',
                //         ),
                //       ),
                //     ),
                //     ListTile(
                //       title: Text('Diseases'),
                //       subtitle: TextField(
                //         obscureText: true,
                //         decoration: InputDecoration(
                //           border: OutlineInputBorder(),
                //           labelText: '',
                //         ),
                //       ),
                //     ),
                //   ],
                // ),

                )));
  } //build

} //Profilepage
