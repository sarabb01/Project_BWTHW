import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:prova_project/models/shopList.dart';
import 'package:prova_project/screens/Rewards/QRcodePage.dart';

class ShoppingPage extends StatelessWidget {
  ShoppingPage({Key? key}) : super(key: key);

  static const route = '/shop';
  static const routename = 'Shopping';
  final shopList shoplist = shopList();
  final earnedPoints = 520;
  @override
  Widget build(BuildContext context) {
    print('${ShoppingPage.routename} built');
    final word = ModalRoute.of(context)!.settings.arguments! as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(ShoppingPage.routename),
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Here you can see the list of shops near "$word" where you can spend your points',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Only the eligible shops are active',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  width: 150,
                  height: 22,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  child: Text(
                    'Your points: $earnedPoints',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: shoplist.Catalog.length,
                    itemBuilder: (_, index) {
                      String key = shoplist.Catalog.keys.elementAt(index);
                      return earnedPoints >= shoplist.Catalog[key]!
                          ? Card(
                              child: ListTile(
                                  title: Text(key),
                                  subtitle: Text(
                                      'Required points : ${shoplist.Catalog[key]}'),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.arrowRight),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, QRcodePage.route);
                                    },
                                  )),
                            )
                          : Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                  title: Text(key,
                                      style: TextStyle(color: Colors.grey)),
                                  subtitle: Text(
                                      'Required points : ${shoplist.Catalog[key]}')),
                            );
                    }),
              )
            ],
          )),
    );
  } //build

} //Page
