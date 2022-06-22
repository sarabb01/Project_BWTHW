import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:the_best_app/Utils/points_displayer.dart';
import 'package:the_best_app/models/shopList.dart';
import 'package:the_best_app/Screens/RewardScreens/QRcodePage.dart';

class ShoppingPage extends StatelessWidget {
  //ShoppingPage({Key? key}) : super(key: key);
  static const route =
      '/hellowordpage/loginpage/homepage/preferencepage/querypage/shoppingpage';
  static const routename = 'Shopping';
  final shopList shoplist = shopList();

  String city;
  double earnedPoints;
  ShoppingPage({required this.city, required this.earnedPoints});

  @override
  Widget build(BuildContext context) {
    print('${ShoppingPage.routename} built');
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
                'Here you can see the list of shops near "$city" where you can spend your points',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 10),
              Text(
                'Only the eligible shops are active',
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Center(child: Points_displayer()),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                    itemCount: shoplist.Catalog.length,
                    itemBuilder: (_, index) {
                      String key = shoplist.Catalog.keys.elementAt(index);
                      return earnedPoints >= shoplist.Catalog[key]![0]
                          ? Card(
                              child: ListTile(
                                  title: Text(key),
                                  subtitle: Text(
                                      'Required points : ${shoplist.Catalog[key]![0]}'),
                                  trailing: IconButton(
                                    icon: Icon(MdiIcons.arrowRight),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, QRcodePage.route,
                                          arguments: {
                                            'n': index,
                                            'type': shoplist.Catalog
                                          });
                                    },
                                  )),
                            )
                          : Card(
                              color: Colors.grey[350],
                              child: ListTile(
                                  title: Text(key,
                                      style: TextStyle(color: Colors.grey)),
                                  subtitle: Text(
                                      'Required points : ${shoplist.Catalog[key]![0]}')),
                            );
                    }),
              )
            ],
          )),
    );
  } //build

} //Page
