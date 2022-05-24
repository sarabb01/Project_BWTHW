import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  static const route = '/Profilepage';
  static const routename = 'Profilepage';

  @override
  Widget build(BuildContext context) {
    print('${Profilepage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(Profilepage.routename),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Profiledatapage');
                },
                icon: Icon(Icons.account_box))
          ],
        ),
        body: Center(
            child: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Dati Anagrafici'),
            ),
            ListTile(
              title: Text('Nome'),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text('Cognome'),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text('Sesso'),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text('Altezza'),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text('Peso'),
              subtitle: Text(''),
            ),
            ListTile(
              title: Text('Malattie Diagnosticate'),
            ),
            ListTile(
              title: Text(''),
            ),
          ],
        )));
  } //build

} //Profilepage