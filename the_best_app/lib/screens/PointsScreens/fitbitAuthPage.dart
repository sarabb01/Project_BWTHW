import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_best_app/screens/PointsScreens/fetchPage.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthPage extends StatelessWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/auth';
  static const routename = 'AuthPage';

  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(AuthPage.routename),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: () {
              Navigator.pushNamed(context, FetchPage.route);
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Authorize the app
                await FitbitConnector.authorize(
                    context: context,
                    clientID: '238L93',
                    clientSecret: '60a1978b8ab3f4d8a226fe238c88a81e',
                    redirectUri: 'thebestapp://fitbit/auth',
                    callbackUrlScheme: 'thebestapp');

                // USELESS!
                // final sp = await SharedPreferences.getInstance();
                // final token = await FitbitConnector.storage.read(key: 'fitbitAccessToken') as String;
                // final refreshToken =  await FitbitConnector.storage.read(key: 'fitbitRefreshToken') as String;
                // sp.setString('fitbitAccessToken', token);
                // sp.setString('fitbitResfreshToken', refreshToken);
              },
              child: Text('Tap to authorize'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FitbitConnector.unauthorize(
                    clientID: '238L93',
                    clientSecret: '60a1978b8ab3f4d8a226fe238c88a81e');
              },
              child: Text('Tap to unauthorize'),
            )
          ],
        ),
      ),
    );
  } //build

} //HomePage
