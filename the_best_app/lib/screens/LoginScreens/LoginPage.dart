// PACKAGES
import 'package:colours/colours.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Utils
import 'package:the_best_app/Utils/back_page_button.dart';

// Screens
import 'package:the_best_app/Screens/LoginScreens/HelloWordPage.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/ForgotPasswordPage.dart';

// Database
import 'package:the_best_app/Repository/database_repository.dart';

// Functions
import 'package:the_best_app/Functions/checkAuthorization.dart';

class LoginPage extends StatefulWidget {
  static const route = '/hellowordpage/loginpage';
  static const routename = 'LoginPage';

  @override
  State<LoginPage> createState() => _log_in_settings();
}

class _log_in_settings extends State<LoginPage> {
  late TextEditingController _username;
  late TextEditingController _password;
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

  @override
  void initState() {
    _username = TextEditingController();
    _password = TextEditingController();
    //Check if the user is already logged in before rendering the login page
    _checkLogin();
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
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

  Future<bool> _User_LogIn(String username, String password) async {
    final result = await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .findUser(username);
    var _user = result?.username;
    var _password = result?.password;
    var _userid = result?.id;
    if (_user != null &&
        _password != null &&
        _password == password &&
        _userid != null) {
      final sp = await SharedPreferences.getInstance();
      sp.setString('username', _user);
      sp.setInt('userid', _userid);
      return await Future<bool>.value(true);
    } else {
      return await Future<bool>.value(false);
    }
  }

  //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
  void _checkLogin() async {
    //Get the SharedPreference instance and check if the value of the 'username' filed is set or not
    final sp = await SharedPreferences.getInstance();
    if (sp.getString('username') != null && sp.getInt('userid') != null) {
      //If 'username is set, push the HomePage
      Navigator.pushReplacementNamed(context, HomePage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Build ${LoginPage.routename}');
    return Scaffold(
      appBar: AppBar(
        leading: Back_Page([10, 10, 5, 5], context, HelloWordPage.route),
        title: Text(
          LoginPage.routename,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              width: 200,
              height: 150,
              child: SvgPicture.asset('assets/Images/register.svg')),
          Container(
              height: 300,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 10),
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 20,
                    color: Colours.darkSeagreen,
                    shadowColor: Colors.black,
                    margin: EdgeInsets.all(10),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Username TextBox
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              autocorrect: false,
                              controller: _username,
                              decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
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
                                  errorText:
                                      user_submitted ? user_errorText : null,
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                          ),
                          SizedBox(height: 5),
                          // Password TextBox
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: TextField(
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.black),
                              autocorrect: false,
                              controller: _password,
                              obscureText: obscure_text,
                              decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 1.0),
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
                                  hintText: 'Enter Your Password',
                                  hintStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                  filled: true,
                                  fillColor: Colors.white,
                                  errorText: password_submitted
                                      ? pass_errorText
                                      : null,
                                  errorStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15)),
                            ),
                          ),
                        ],
                      ),
                    )),
              )),
          SizedBox(
            height: 5,
          ),
          Center(
              child: Padding(
            // LOG-IN
            padding: EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
            child: ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colours.seaGreen)),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                  backgroundColor: MaterialStateProperty.all(
                      Colours.seaGreen), // <-- Button color
                  overlayColor:
                      MaterialStateProperty.resolveWith<Color?>((states) {
                    if (states.contains(MaterialState.pressed))
                      return Colors.red; // <-- Splash color
                  })),
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, top: 1, right: 20, bottom: 1),
                child: Column(
                  children: [
                    Icon(
                      Icons.login,
                      color: Colors.black,
                    ),
                    Text(
                      'Log-In',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              onPressed: () async {
                if (_username.text.isEmpty || _password.text.isEmpty) {
                  _username.text.isEmpty ? user_submit() : null;
                  _password.text.isEmpty ? pass_submit() : null;
                } else if (await _User_LogIn(_username.text, _password.text)) {
                  await checkAuthorization(context);
                  Navigator.pushReplacementNamed(
                    context,
                    HomePage.route,
                  );
                  setInputData(); // To Clear the content of TextEditingController()
                } else {
                  showDialog<void>(
                      context: context,
                      builder: (BuildContext context) {
                        Future.delayed(Duration(seconds: 5), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                            actionsAlignment: MainAxisAlignment.center,
                            title: Text(
                              'Wrong Access',
                              textAlign: TextAlign.center,
                            ),
                            content: Text("Wrong Credentials",
                                textAlign: TextAlign.center),
                            actions: <Widget>[
                              IconButton(
                                icon: Icon(Icons.error),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ]);
                      });
                }
              },
            ),
          )),
          Padding(
              // FORGOT PASSWORD
              padding:
                  EdgeInsets.only(right: 5.0, bottom: 5, left: 5.0, top: 5),
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colours.seaGreen)),
                      ),
                      padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                      backgroundColor: MaterialStateProperty.all(
                          Colours.seaGreen), // <-- Button color
                      overlayColor:
                          MaterialStateProperty.resolveWith<Color?>((states) {
                        if (states.contains(MaterialState.pressed))
                          return Colors.red; // <-- Splash color
                      })),
                  onPressed: (() {
                    Navigator.pushReplacementNamed(
                        context, ForgotPasswordPage.route);
                    ;
                  }),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 5),
                    child: Text(
                      'Forgot Password ',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  )))
        ])),
      ),
    );
  }
}
