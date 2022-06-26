import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:the_best_app/Screens/PointsScreens/fetchPage.dart';
//import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AuthPage extends StatefulWidget {
  AuthPage({Key? key}) : super(key: key);

  static const route = '/auth';
  static const routename = 'AuthPage';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  String _state = '';
  @override
  void initState() {
    _state = 'Authorization denied';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('${AuthPage.routename} built');
    return Scaffold(
      appBar: AppBar(
        title: Text(AuthPage.routename),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.arrow_forward_ios),
        //     onPressed: () {
        //       Navigator.pushNamed(context, FetchPage.route);
        //     },
        //   )
        // ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$_state'),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                // Authorize the app
                await FitbitConnector.authorize(
                    context: context,
                    clientID: '238L93',
                    clientSecret: '60a1978b8ab3f4d8a226fe238c88a81e',
                    redirectUri: 'thebestapp://fitbit/auth',
                    callbackUrlScheme: 'thebestapp');

                setState(() {
                  _state = 'Authorization Succedeed';
                });
              },
              child: Text('Tap to authorize'),
            ),
            ElevatedButton(
              onPressed: () async {
                await FitbitConnector.unauthorize(
                    clientID: '238L93',
                    clientSecret: '60a1978b8ab3f4d8a226fe238c88a81e');
                setState(() {
                  _state = 'Authorization denied';
                });
              },
              child: Text('Tap to unauthorize'),
            )
          ],
        ),
      ),
    );
  }
} //HomePage

