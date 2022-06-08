import 'package:flutter/material.dart';
import 'package:the_best_app/screens/profiledatapage.dart';

class Profilepage extends StatelessWidget {
  Profilepage({Key? key}) : super(key: key);

  static const route = '/hellowordpage/loginpage/homepage/profilepage';
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
                  Navigator.pushNamed(context, Profiledatapage.route);
                },
                icon: Icon(Icons.account_box))
          ],
        ),
        body: Center(
            child: SizedBox(
                child: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Personal Data'),
            ),
            ListTile(
                title: Text('Name'),
                subtitle: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '',
                  ),
                )),
            ListTile(
              title: Text('Surname'),
              subtitle: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
            ListTile(
              title: Text('Sex'),
              subtitle: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
            ListTile(
              title: Text('Height'),
              subtitle: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
            ListTile(
              title: Text('Weight'),
              subtitle: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
            ListTile(
              title: Text('Diseases'),
              subtitle: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '',
                ),
              ),
            ),
          ],
        ))));
  } //build

} //Profilepage