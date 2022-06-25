// PACKAGES
import 'dart:ui';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:colours/colours.dart';
// APP SCREENS
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/RegistrationPage.dart';
// DATA PERSISTENCE
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Repository/database_repository.dart';

class ForgotPasswordPage extends StatefulWidget {
  static const route = '/hellowordpage/loginpage/forgotpasswordpage';
  static const routename = 'Forgot PassWord Page';

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late TextEditingController _username; // = TextEditingController();
  late TextEditingController _password; // = TextEditingController();
  bool obscure_text = true;

  bool user_submitted = false;
  bool password_submitted = false;

  String? get user_errorText {
    final user_text = _username.text;
    if (user_text.isEmpty || user_text == null) {
      return 'Must not be empty';
    }
  }

  String? get pass_errorText {
    String pass_text = _username.text;
    if (pass_text.isEmpty || pass_text == null) {
      return 'Must not be empty';
    } else if (pass_text.length < 8 &&
        pass_text.isNotEmpty &&
        pass_text != null) {
      return "Password Too Short (Min 8 Character Recquired)";
    }
  }

  @override
  void initState() {
    super.initState();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _username.dispose();
    _password.dispose();
  }

  void user_submit() {
    setState(() {
      user_submitted = true;
    });
  }

  void pass_submit() {
    setState(() {
      password_submitted = true;
    });
  }

  void setInputData() {
    setState(() {
      _username.clear();
      _password.clear();
    });
  }

  void set_ObscureText() {
    setState(() {
      obscure_text = !obscure_text;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          ForgotPasswordPage.routename,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Back_Page([5, 10, 5, 5], context, LoginPage.route)
        ],
      ),
      backgroundColor: Colours.white,
      body: Center(
        child: Form(
          child: Container(
            height: 300,
            width: 350,
            child: Card(
              color: Colours.mediumSeaGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 30,
              child: Padding(
                padding: EdgeInsets.only(
                    right: 10.0, bottom: 10, left: 10.0, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0, bottom: 10, left: 10.0, top: 10),
                      child: TextField(
                        controller: _username,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black),
                        autocorrect: false,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colours.aliceBlue, width: 1.0),
                            ),
                            iconColor: Colors.black,
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Colors.black,
                            ),
                            hintText: 'Enter a Valid Mail Adress',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            filled: true,
                            fillColor: Colors.white,
                            errorText: user_submitted ? user_errorText : null,
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          right: 10.0, bottom: 10, left: 10.0, top: 20),
                      child: TextField(
                        textAlign: TextAlign.center,
                        autocorrect: false,
                        controller: _password,
                        style: TextStyle(color: Colors.black),
                        obscureText: obscure_text,
                        decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colours.aliceBlue, width: 1.0),
                            ),
                            iconColor: Colors.black,
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.black,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                MdiIcons.eye,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                set_ObscureText();
                              },
                            ),
                            hintText: 'Enter New Password',
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                            filled: true,
                            fillColor: Colors.white,
                            errorText:
                                password_submitted ? pass_errorText : null,
                            errorStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15)),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Colours.darkSeagreen)),
                          ),
                          padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                          backgroundColor: MaterialStateProperty.all(
                              Colours.darkSeagreen), // <-- Button color
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color?>(
                                  (states) {
                            if (states.contains(MaterialState.pressed))
                              return Colors.red; // <-- Splash color
                          })),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 20, top: 1, right: 20, bottom: 1),
                        child: Column(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            Text(
                              'Edit New Password',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      onPressed: () async {
                        if (await new_password(
                            _username.text, _password.text)) {
                        } else {
                          setInputData();
                          showDialog<void>(
                              context: context,
                              builder: (BuildContext context) {
                                Future.delayed(Duration(seconds: 10), () {
                                  Navigator.of(context).pop(true);
                                });
                                return AlertDialog(
                                    actionsAlignment: MainAxisAlignment.center,
                                    title: Text(
                                      '!!! Username Not Found !!!',
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Text(
                                        "Please enter a valid username or create a new account",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center),
                                    actions: <Widget>[
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 5.0,
                                                  bottom: 10,
                                                  left: 10.0,
                                                  top: 10),
                                              child: ElevatedButton(
                                                child: Container(
                                                  width: screenSize.width / 4,
                                                  padding: EdgeInsets.only(
                                                      right: 10.0,
                                                      bottom: 10,
                                                      left: 10.0,
                                                      top: 10),
                                                  child: Column(children: [
                                                    Icon(Icons.close),
                                                    Text('Retry',
                                                        style: TextStyle(
                                                            fontSize: 10))
                                                  ]),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: 10.0,
                                                  bottom: 10,
                                                  left: 5.0,
                                                  top: 10),
                                              child: ElevatedButton(
                                                child: Container(
                                                  width: screenSize.width / 4,
                                                  padding: EdgeInsets.only(
                                                      right: 10.0,
                                                      bottom: 10,
                                                      left: 10.0,
                                                      top: 10),
                                                  child: Column(children: [
                                                    Icon(
                                                        Icons.app_registration),
                                                    Text(
                                                      'New Account',
                                                      style: TextStyle(
                                                          fontSize: 10),
                                                    )
                                                  ]),
                                                ),
                                                onPressed: () {
                                                  Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          RegistrationPage
                                                              .route);
                                                },
                                              ),
                                            ),
                                          ]),
                                    ]);
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> new_password(String username, String password) async {
    final result = await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .findUser(username);
    if (result != null) {
      // That means that this account is already siged in the application
      final edited_user =
          UsersCredentials(result.id, result.username, password);
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .updateUserPassword(edited_user);
      setInputData();
      await Navigator.pushReplacementNamed(context, LoginPage.route);
      return true;
    } else {
      return false;
    }
  }

  Widget Back_Page(
      List<double> edge_insets, BuildContext context, String pageroute) {
    return Padding(
        padding: EdgeInsets.only(
            left: edge_insets[0],
            right: edge_insets[1],
            bottom: edge_insets[2],
            top: edge_insets[3]),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                backgroundColor: MaterialStateProperty.all(
                    Colours.darkSeagreen), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                })),
            onPressed: (() async {
              await Navigator.pushReplacementNamed(context, pageroute);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
