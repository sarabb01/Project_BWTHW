// FLUTTER PACKAGES
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
// SCREENS
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
// UTILIS
import 'package:the_best_app/Utils/Form_Separator.dart';
import 'package:the_best_app/Utils/Registration_Form.dart';
// DATA PERSISTENCE
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Repository/database_repository.dart';

class RegistrationPage extends StatefulWidget {
  static const route = '/hellowordpage/registrationpage';
  static const routename = 'Registration Page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController _name; // = TextEditingController();
  late TextEditingController _surname; // = TextEditingController();
  late TextEditingController _sex; // = TextEditingController();
  late TextEditingController _username; // = TextEditingController();
  late TextEditingController _password; // = TextEditingController();
  late TextEditingController _age; // = TextEditingController();

  Color text_color_name = Colors.black;
  Color text_color_surname = Colors.black;
  Color text_color_age = Colors.black;
  Color text_color_sex = Colors.black;
  Color text_color_username = Colors.black;
  Color text_color_password = Colors.black;

  @override
  void initState() {
    _name = TextEditingController();
    _surname = TextEditingController();
    _sex = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _age = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _sex.dispose();
    _username.dispose();
    _password.dispose();
    _age.dispose();
    super.dispose();
  }

  setInputData() {
    setState(() {
      _name.clear();
      _surname.clear();
      _sex.clear();
      _username.clear();
      _password.clear();
      _age.clear();
    });
  }

  field_check_name() {
    if (_name.text.isEmpty || _name.text == null) {
      setState(() {
        text_color_name = Colors.red;
      });
    }
  }

  field_check_surname() {
    if (_surname.text.isEmpty || _surname.text == null) {
      setState(() {
        text_color_surname = Colors.red;
      });
    }
  }

  field_check_age() {
    if (_age.text.isEmpty || _age.text == null) {
      setState(() {
        text_color_age = Colors.red;
      });
    }
  }

  field_check_sex() {
    if (_sex.text.isEmpty || _sex.text == null) {
      setState(() {
        text_color_sex = Colors.red;
      });
    }
  }

  field_check_username() {
    if (_username.text.isEmpty || _username.text == null) {
      setState(() {
        text_color_username = Colors.red;
      });
    }
  }

  field_check_password() {
    if (_password.text.isEmpty || _password.text == null) {
      setState(() {
        text_color_password = Colors.red;
      });
    }
  }

  bool input_fields_check(
    TextEditingController controller1,
    TextEditingController controller2,
    TextEditingController controller3,
    TextEditingController controller4,
    TextEditingController controller5,
    TextEditingController controller6,
  ) {
    if ((controller1.text.isNotEmpty || controller1.text != null) &&
        (controller2.text.isNotEmpty || controller2.text != null) &&
        (controller3.text.isNotEmpty || controller3.text != null) &&
        (controller4.text.isNotEmpty || controller4.text != null) &&
        (controller5.text.isNotEmpty || controller5.text != null) &&
        (controller6.text.isNotEmpty || controller6.text != null)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    print('${RegistrationPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            RegistrationPage.routename,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Back_Page([5, 10, 5, 5], context)
          ],
        ),
        body: Center(
            child: ListView(children: [
          Text(
            'New Account',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset('assets/Images/placeholder.jpg'),
            ),
          ),
          FormSeparator(label: 'Name'),
          Inp_Reg_Text(
            controller: _name,
            label: 'Enter your Name',
          ),
          FormSeparator(label: 'Surname'),
          Inp_Reg_Text(
            controller: _surname,
            label: 'Enter your Surname',
          ),
          FormSeparator(label: 'Age'),
          Inp_Reg_Num(
            controller: _age,
            label: 'Subject Age',
          ),
          FormSeparator(label: 'Sex'),
          Inp_Reg_Text(
            controller: _sex,
            label: 'Female or Male',
          ),
          FormSeparator(label: 'Username'),
          Inp_Reg_Text(
            controller: _username,
            label: 'Email Addres',
          ),
          FormSeparator(label: 'Password'),
          Inp_Reg_Text(
            controller: _password,
            label: 'Enter your Password',
          ),
          Sign_In_Button(context, LoginPage.route),
        ])));
  }

  Widget Sign_In_Button(BuildContext context, String route) {
    return Padding(
        padding: EdgeInsets.only(right: 5.0, bottom: 15, left: 5.0, top: 10),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                backgroundColor: MaterialStateProperty.all(
                    Colours.mediumSeaGreen), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                })),
            onPressed: (() async {
              if (input_fields_check(
                  _name, _surname, _age, _sex, _username, _password)) {
                user_info_storing(_username.text, _password.text);
                //setInputData();
                await Navigator.pushReplacementNamed(context, LoginPage.route);
              }
            }),
            child: Padding(
                padding:
                    EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 5),
                child: Column(children: [
                  Icon(
                    Icons.app_registration,
                    color: Colors.black,
                    size: 30,
                  ),
                  Text(
                    'Sign In',
                    style: TextStyle(color: Colors.black),
                  )
                ]))));
  }

  void user_info_storing(String username, String password) async {
    final usersCredentials = UsersCredentials(1, username, password);
    await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .addUser(usersCredentials);
  }

  Widget Back_Page(List<double> edgeInsets, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 5),
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
              await setInputData();
              await Navigator.pushReplacementNamed(context, LoginPage.route);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
