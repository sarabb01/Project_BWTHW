import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

Widget PassWord_format(final password) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.black),
      autocorrect: false,
      controller: password,
      obscureText: true,
      decoration: new InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        iconColor: Colors.black,
        labelText: 'Password',
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        prefixIcon: Icon(
          Icons.lock,
          color: Colors.black,
        ),
        suffixIcon: Icon(
          MdiIcons.eye,
          color: Colors.black,
        ),
        hintText: 'Enter Your Password',
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}

Widget Username_format(final username) {
  return Padding(
    padding: EdgeInsets.all(10),
    child: TextField(
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
      autocorrect: false,
      controller: username,
      decoration: new InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 1.0),
        ),
        iconColor: Colors.black,
        labelText: 'Username',
        labelStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        prefixIcon: Icon(
          Icons.account_circle,
          color: Colors.black,
        ),
        hintText: 'Enter a Valid Mail Adress',
        hintStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
        filled: true,
        fillColor: Colors.white,
      ),
    ),
  );
}
