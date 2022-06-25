import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/functions/dateFormatter.dart';
import 'package:the_best_app/Screens/RewardScreens/selectPrefPage.dart';
import 'package:the_best_app/Screens/profiledatapage.dart';

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
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Profiledatapage.route);
                },
                icon: Icon(Icons.account_box))
          ],
        ),
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
                                  print(info.id);

                                  return FutureBuilder(
                                      future: Provider.of<UsersDatabaseRepo>(
                                              context,
                                              listen: false)
                                          .checkUserInfos(info.id!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          final data =
                                              snapshot.data as UserInfos;

                                          print(data.name);
                                          return ListView(
                                            children: <Widget>[
                                              ListTile(
                                                title:
                                                    const Text('Personal Data'),
                                              ),
                                              ListTile(
                                                  title: Text('Name'),
                                                  subtitle: TextField(
                                                    obscureText: true,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      labelText: data.name,
                                                    ),
                                                  )),
                                              ListTile(
                                                title: Text('Surname'),
                                                subtitle: TextField(
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: data.surname,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Date of Birth'),
                                                subtitle: TextField(
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: dateFormatter(
                                                        data.dateofbirth,
                                                        opt: 2),
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Gender'),
                                                subtitle: TextField(
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: data.gender,
                                                  ),
                                                ),
                                              ),
                                              ListTile(
                                                title: Text('Target'),
                                                subtitle: TextField(
                                                  obscureText: true,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: data.usertarget,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        } else {
                                          return CircularProgressIndicator();
                                        }
                                      });
                                } else {
                                  return ListView(
                                    children: <Widget>[
                                      ListTile(
                                        title: const Text('Personal Data'),
                                      ),
                                      ListTile(
                                          title: Text('Name'),
                                          subtitle: TextField(
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: '',
                                            ),
                                          )),
                                      ListTile(
                                        title: Text('Surname'),
                                        subtitle: TextField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('Date of Birth'),
                                        subtitle: TextField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('Gender'),
                                        subtitle: TextField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        title: Text('Target'),
                                        subtitle: TextField(
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: '',
                                          ),
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
