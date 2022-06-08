import 'package:flutter/material.dart';

class Profiledatapage extends StatelessWidget {
  Profiledatapage({Key? key}) : super(key: key);

  static const route =
      '/hellowordpage/loginpage/homepage/profilepage/profiledatapage';
  static const routename = 'Profile data';

  @override
  Widget build(BuildContext context) {
    print('${Profiledatapage.routename} built');
    return Scaffold(
        appBar: AppBar(
          title: Text(Profiledatapage.routename),
        ),
        body: Drawer(
            child: SizedBox(
                height: 200,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colours.azure)
                        ),
                        title: const Text('Modify my profile'),
                        trailing: IconButton(
                          icon: Icon(Icons.more_vert),
                          //heroTag: 'btn1',
                          onPressed: () {
                            Navigator.pop(
                                context, '/hellowordpage/registrationpage');
                          },
                        ),
                        tileColor: Colors.green[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colours.azure)
                        ),
                        title: const Text('Logout'),
                        trailing: IconButton(
                          icon: Icon(Icons.logout),
                          //heroTag: 'btn2',
                          onPressed: () {},
                        ),
                        tileColor: Colors.green[100],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 10),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          //side: BorderSide(color: Colours.azure)
                        ),
                        title: const Text('Remove my account'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),

                          //heroTag: 'btn3',
                          onPressed: () {
                            Navigator.pop(context, '/hellowordpage');
                          },
                        ),
                        tileColor: Colors.green[100],
                      ),
                    )
                  ],
                ))));
  } //build

} //Page