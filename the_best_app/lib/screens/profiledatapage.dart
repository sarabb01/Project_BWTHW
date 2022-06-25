import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/LoginScreens/RegistrationPage.dart';

class Profiledatapage extends StatelessWidget {
  Profiledatapage({Key? key}) : super(key: key);

  static const route =
      '/hellowordpage/loginpage/homepage/profilepage/profiledatapage';
  static const routename = 'Profile Data Page';

  @override
  Widget build(BuildContext context) {
    print('${Profiledatapage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(Profiledatapage.routename),
        ),
        body: Drawer(
            child: SizedBox(
                height: 200,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colours.azure)
                        ),
                        title: const Text('Modify my profile'),
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert),
                          //heroTag: 'btn1',
                          onPressed: () {
                            Navigator.pop(context, RegistrationPage.route);
                          },
                        ),
                        tileColor: Colors.green[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colours.azure)
                        ),
                        title: const Text('Remove my account'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),

                          //heroTag: 'btn3',
                          onPressed: () async {
                            final sp = await SharedPreferences.getInstance();
                            final name = sp.getString('username');
                            print(name);
                            final result = await Provider.of<UsersDatabaseRepo>(
                                    context,
                                    listen: false)
                                .findUser(name!);
                            var _user = result!.username;
                            print(_user);
                            if (result != null) {
                              sp.remove('username');
                              await Provider.of<UsersDatabaseRepo>(context,
                                      listen: false)
                                  .deleteUser(result);
                            }

                            await Navigator.pushNamed(
                                context, HelloWordPage.route);
                          },
                        ),
                        tileColor: Colors.green[100],
                      ),
                    )
                  ],
                ))));
  } //build

} //Page