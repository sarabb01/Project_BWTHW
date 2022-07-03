// Flutter Packages
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Screens
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';

// Utils
import 'package:the_best_app/Utils/Form_Separator.dart';
import 'package:the_best_app/Utils/Reg_Form.dart';
import 'package:the_best_app/Utils/DateFormats.dart';
import 'package:the_best_app/Utils/back_page_button.dart';

// Database
import 'package:the_best_app/Database/Entities/UserCreds.dart';
import 'package:the_best_app/Repository/database_repository.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';

class RegistrationPage extends StatefulWidget {
  static const route = '/hellowordpage/registrationpage';
  static const routename = 'Registration Page';

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late TextEditingController _name;
  late TextEditingController _surname;
  late TextEditingController _username;
  late TextEditingController _password;

  late DateTime _selectedDate;
  late String? _selectedGender;
  late String? _selectedTarget;

  //Form globalkey: this is required to validate the form fields.
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _name = TextEditingController();
    _surname = TextEditingController();
    _username = TextEditingController();
    _password = TextEditingController();
    _selectedDate = DateTime(
        (DateTime.now()).year, (DateTime.now()).month, (DateTime.now()).day);
    _selectedGender = 'None';
    _selectedTarget = 'None';
    super.initState();
  }

  // For Text Editing Controller Widget
  @override
  void dispose() {
    _name.dispose();
    _surname.dispose();
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  setInputData() {
    setState(() {
      _name.clear();
      _surname.clear();
      _username.clear();
      _password.clear();
      _selectedDate = DateTime(
          (DateTime.now()).year, (DateTime.now()).month, (DateTime.now()).day);
      _selectedGender = 'None';
      _selectedTarget = 'None';
    });
  }

  @override
  Widget build(BuildContext context) {
    print('${RegistrationPage.routename} built');
    return Scaffold(
        appBar: AppBar(
          leading: Back_Page([5, 10, 5, 5], context, LoginPage.route),
          title: Text(
            RegistrationPage.routename,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
            child: Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 20, right: 20),
                    child: ListView(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          height: 100,
                          width: 200,
                          child: Image.asset('assets/Images/logo5.png'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'New Account',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0),
                        ),
                      ),
                      FormSeparator(label: 'Name'),
                      FormTextTile(
                        controller: _name,
                        labelText: 'Enter your Name',
                      ),
                      FormSeparator(label: 'Surname'),
                      FormTextTile(
                        controller: _surname,
                        labelText: 'Enter your Surname',
                      ),
                      FormSeparator(label: 'Date of Birth'),
                      FormDateTile(
                        labelText: "Select your Date of Birth",
                        date: _selectedDate,
                        dateFormat: Formats.onlyDayDateFormat,
                        onPressed: () {
                          _selectDate(context);
                        },
                      ),
                      FormSeparator(label: 'Gender'),
                      DropdownButtonTileString(
                        items: ['Female', 'Male', 'None'],
                        labelText: 'Female or Male',
                        notifyParent: selectGender,
                      ),
                      FormSeparator(label: 'Target'),
                      DropdownButtonTileString(
                        items: ['Basic', 'Medium', 'Advanced', 'None'],
                        labelText: 'Personal Target',
                        notifyParent: selectTarget,
                      ),
                      FormSeparator(label: 'Username'),
                      FormTextTile(
                        controller: _username,
                        labelText: 'Enter your Email Addres',
                      ),
                      FormSeparator(label: 'Password'),
                      FormTextTile(
                        controller: _password,
                        labelText: 'Enter your Password',
                      ),
                      Sign_In_Button(context, LoginPage.route),
                    ])))));
  }

  //Utility method that implements a Date+Time picker.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(1960),
        lastDate: DateTime(2060));

    if (picked != null && picked != _selectedDate)
      //Here, I'm using setState to update the _selectedDate field and rebuild the UI.
      setState(() {
        _selectedDate = picked;
      });
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
              if (formKey.currentState!.validate()) {
                if (await Provider.of<UsersDatabaseRepo>(context, listen: false)
                        .findUser(_username.text) ==
                    null) {
                  await user_data_storing(
                    _name.text,
                    _surname.text,
                    _selectedGender!,
                    _selectedDate,
                    _selectedTarget!,
                    _username.text,
                    _password.text,
                  );
                  setInputData();
                  await Navigator.pushReplacementNamed(
                      context, LoginPage.route);
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            actionsAlignment: MainAxisAlignment.center,
                            title: Text(
                              '!!! This Username Already Exists !!!',
                              textAlign: TextAlign.center,
                            ),
                            content: Text(
                                "Please enter a not-already used username",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 10.0,
                                      bottom: 10,
                                      left: 10.0,
                                      top: 10),
                                  child: Column(children: [
                                    Icon(Icons.close),
                                    Text('Retry',
                                        style: TextStyle(fontSize: 10))
                                  ]),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _username.clear();
                                  });
                                  Navigator.pop(context);
                                },
                              ),
                            ]);
                      });
                }
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

  dynamic selectGender(_currentchoice) {
    setState(() {
      _selectedGender = _currentchoice;
    });
  }

  dynamic selectTarget(_currentchoice) {
    setState(() {
      _selectedTarget = _currentchoice;
    });
  }

  Future<void> user_data_storing(
      String name,
      String surname,
      String gender,
      DateTime dateofbirth,
      String target,
      String username,
      String password) async {
    final usersCredentials = UsersCredentials(null, username, password);
    await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .addUser(usersCredentials);
    final user = await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .findUser(username);
    if (user != null) {
      final user_infos =
          UserInfos(null, user.id!, name, surname, gender, dateofbirth, target);
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .addUserInfos(user_infos);
    }
  }
}
