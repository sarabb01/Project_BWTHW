// Flutter Packages
import 'package:colours/colours.dart';
import 'package:flutter/material.dart';

// Widget Description :Back Page Button Widget
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
              elevation: MaterialStateProperty.all(0), // <- Button Elevation
              shape:
                  MaterialStateProperty.all(CircleBorder()), // <- Button Shape
              padding: MaterialStateProperty.all(
                  EdgeInsets.all(5)), // <- Button Padding
              backgroundColor: MaterialStateProperty.all(
                  Colours.darkSeagreen), // <- Button background color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.white38; // <- Splash color
              })),
          onPressed: (() async {
            await Navigator.pushReplacementNamed(context, pageroute);
          }),
          child: Icon(
            Icons.first_page,
            color: Colors.white,
            size: 30,
          )));
}

// Widget Description :Back Page Button Widget with Page Arugments
Widget Back_Page_withArgs(
    List<double> edge_insets, BuildContext context, String pageroute, Map arg) {
  return Padding(
      padding: EdgeInsets.only(
          left: edge_insets[0],
          right: edge_insets[1],
          bottom: edge_insets[2],
          top: edge_insets[3]),
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0), // <- Button Elevation
              shape:
                  MaterialStateProperty.all(CircleBorder()), // <- Button Shape
              padding: MaterialStateProperty.all(
                  EdgeInsets.all(5)), // <- Button Padding
              backgroundColor: MaterialStateProperty.all(
                  Colours.darkSeagreen), // <- Button background color
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed))
                  return Colors.white38; // <-- Splash color
              })),
          onPressed: (() async {
            await Navigator.pushReplacementNamed(context, pageroute,
                arguments: arg);
          }),
          child: Icon(
            Icons.first_page,
            color: Colors.white,
            size: 30,
          )));
}
