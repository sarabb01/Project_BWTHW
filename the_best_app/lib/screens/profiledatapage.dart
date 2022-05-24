import 'package:flutter/material.dart';

class Profiledatapage extends StatelessWidget {
  Profiledatapage({Key? key}) : super(key: key);

  static const route = '/Profiledatapage';
  static const routename = 'Profile data';

  @override
  Widget build(BuildContext context) {
    print('${Profiledatapage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(Profiledatapage.routename),
        ),
        body: Drawer(
            child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Modifica Profilo'),
              trailing: Icon(Icons.more_vert),
            ),
            ListTile(
              title: Text('Cancella i miei dati'),
              trailing: Icon(Icons.delete),
            ),
            ListTile(
              title: Text('Logout'),
              trailing: Icon(Icons.logout),
            ),
          ],
        )));
  } //build

} //Page