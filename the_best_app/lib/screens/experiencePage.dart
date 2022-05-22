import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_project/models/locations.dart';
import 'package:http/http.dart' as http;

class Opt2Page extends StatelessWidget {
  Opt2Page({Key? key}) : super(key: key);

  static const route = '/exp';
  static const routename = 'Experiences';
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print('${Opt2Page.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(Opt2Page.routename),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: myController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.location_on, color: Colors.green),
                      labelText: 'Insert Location',
                      border: UnderlineInputBorder()),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      //ListView.builder(itemBuilder: (context, item) {
                      //return
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Card(
                                child: FutureBuilder(
                                    future: _fetchStore(myController.text),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        final store = snapshot.data as Location;
                                        return ListTile(
                                          title: Text(store.shopName),
                                          subtitle: Text(store.shopAddress),
                                        );
                                      } else {
                                        return Center(
                                            child: CircularProgressIndicator());
                                        ;
                                      }
                                    }));
                          });
                    },
                    //   ListView(
                    //     children: [
                    //       FutureBuilder(
                    //           future: _fetchStore(myController.text),
                    //           builder: (context, snapshot) {
                    //             if (snapshot.hasData) {
                    //               final store = snapshot.data as Location;
                    //               return ListTile(
                    //                 title: Text(store.shopName),
                    //                 subtitle: Text(store.shopAddress),
                    //               );
                    //             } else {
                    //               return ListTile(
                    //                   trailing: CircularProgressIndicator());
                    //             }
                    //           })
                    //     ],
                    //   );
                    //   //});
                    // },
                    child: Text('Search')),
                SizedBox(height: 20),
                Text(
                  'Here you can find the available experiences close to your position',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
              ],
            )),
      ),
    );
  } //build

} //Page

Future<Location?> _fetchStore(String place) async {
  final url = 'https://jsonplaceholder.typicode.com/posts/1}';
  final response = await http.get(Uri.parse(url));
  return response.statusCode == 200
      ? Location.fromJson(jsonDecode(response.body))
      : null;
}
