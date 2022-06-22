// FLUTTER PACKAGES
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:select_form_field/select_form_field.dart';
import 'package:the_best_app/Database/Entities/UserInfos.dart';
// SCREENS
import 'package:the_best_app/Screens/HomeScreens/HomePage.dart';
import 'package:the_best_app/Screens/LoginScreens/LoginPage.dart';
import 'package:the_best_app/Utils/DateFormats.dart';
// UTILIS
import 'package:the_best_app/Utils/Form_Separator.dart';
import 'package:the_best_app/Utils/Reg_Form.dart';
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
  late TextEditingController _username; // = TextEditingController();
  late TextEditingController _password; // = TextEditingController();

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
            child: Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 8, left: 20, right: 20),
                    child: ListView(children: <Widget>[
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
                        items: ['Target1', 'Target2', 'Target3', 'None'],
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
  } //_selectDate

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
                user_cred_storing(_username.text, _password.text);
                user_info_storing(_username.text, _name.text, _surname.text,
                    _selectedGender!, _selectedDate, _selectedTarget!);
                setInputData();
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

  Future<void> user_cred_storing(String username, String password) async {
    if (await Provider.of<UsersDatabaseRepo>(context, listen: false)
            .findUser(username) ==
        null) {
      final usersCredentials = UsersCredentials(null, username, password);
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .addUser(usersCredentials);
    }
  }

  Future<void> user_info_storing(String username, String name, String surname,
      String gender, DateTime dateofbirth, String target) async {
    final user = await Provider.of<UsersDatabaseRepo>(context, listen: false)
        .findUser(username);
    print(user);
    if (user != null) {
      print([user.id!, name, surname, gender]);
      final user_infos =
          UserInfos(null, user.id!, name, surname, gender, dateofbirth, target);
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .addUserInfos(user_infos);
    }
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
            onPressed: (() {
              setInputData();
              Navigator.pushReplacementNamed(context, LoginPage.route);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
