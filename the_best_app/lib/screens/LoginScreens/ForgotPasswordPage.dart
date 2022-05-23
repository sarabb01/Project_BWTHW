import 'package:flutter/material.dart';
import 'package:prova_project/Screens/LoginScreens/LoginPage.dart';
import 'package:colours/colours.dart';

class ForgotPasswordPage extends StatelessWidget {
  static const route = '/hellowordpage/loginpage/forgotpasswordpage';
  static const routename = 'Forgot PassWord Page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          ForgotPasswordPage.routename,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Back_Page([5, 10, 5, 5], context)
        ],
      ),
      backgroundColor: Colours.white,
      body: Center(
        child: Form(
          child: Container(
            height: 300,
            width: 350,
            child: Card(
              color: Colours.aliceBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 30,
              child: Padding(
                padding:
                    EdgeInsets.only(right: 5.0, bottom: 10, left: 5.0, top: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Email Your Email',
                        style: TextStyle(fontSize: 30, color: Colors.black),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ]),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        icon: Icon(
                          Icons.mail,
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(color: Colors.black),
                        labelStyle: TextStyle(color: Colors.black),
                        hintStyle: TextStyle(color: Colors.black),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text('Send Email'),
                      onPressed: () {},
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
              await Navigator.pushReplacementNamed(context, LoginPage.route);
            }),
            child: Icon(
              Icons.first_page,
              color: Colors.black,
              size: 30,
            )));
  }
}
