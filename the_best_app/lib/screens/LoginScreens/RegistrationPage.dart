import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Utils/Form_Separator.dart';
import 'package:the_best_app/Utils/Registration_Form.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  static const route = '/hellowordpage/registrationpage';
  static const routename = 'Registration Page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _name; // = TextEditingController();
  late TextEditingController _surname; // = TextEditingController();
  late TextEditingController _sex; // = TextEditingController();
  late TextEditingController _username; // = TextEditingController();
  late TextEditingController _password; // = TextEditingController();

  @override
  void initState() {
    super.initState();
    _name = TextEditingController();
    _surname = TextEditingController();
    _sex = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _sex.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  setInputData() {
    setState(() {
      _name.clear();
      _surname.clear();
      _sex.clear();
      _username.clear();
      _password.clear();
    });
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
          Inputs_Forms(
            controller: _name,
            label: 'Enter your Name',
            onSubmit: (value) => print(value),
          ),
          FormSeparator(label: 'Surname'),
          Inputs_Forms(
              controller: _surname,
              label: 'Enter your Surname',
              onSubmit: (value) => print(value)),
          FormSeparator(label: 'Sex'),
          Inputs_Forms(
              controller: _sex,
              label: 'Female or Male',
              onSubmit: (value) => print(value)),
          FormSeparator(label: 'Username'),
          Inputs_Forms(
              controller: _username,
              label: 'Email Addres',
              onSubmit: (value) => print(value)),
          FormSeparator(label: 'Password'),
          Inputs_Forms(
              controller: _password,
              label: 'Enter your Password',
              onSubmit: (value) => print(value)),
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
                backgroundColor:
                    MaterialStateProperty.all(Colors.blue), // <-- Button color
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed))
                    return Colors.red; // <-- Splash color
                })),
            onPressed: (() async {
              await setInputData();
              await Navigator.popAndPushNamed(context, LoginPage.route);
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
                  Text('Sign In')
                ]))));
  }

  Widget Back_Page(List<double> edge_insets, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 5),
        child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStateProperty.all(CircleBorder()),
                padding: MaterialStateProperty.all(EdgeInsets.all(5)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.lime), // <-- Button color
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
