import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Opt1Page extends StatelessWidget {
  Opt1Page({Key? key}) : super(key: key);

  static const route = '/shop';
  static const routename = 'Shopping Page';

  @override
  Widget build(BuildContext context) {
    print('${Opt1Page.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(Opt1Page.routename),
      ),
      body: Center(
        child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Here you can find the shops close to your position',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                Expanded(
                    child: ListView(
                  children: [
                    ListTile(
                      title: Text('Sportler'),
                    ),
                    ListTile(
                      title: Text('Decathlon'),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  } //build

} //Page
