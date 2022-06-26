import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
import 'package:the_best_app/Utils/stringsKeywords.dart';

Future<void> checkAuthorization(BuildContext context) async {
  //final accessToken = await FitbitConnector.storage.read(key: 'fitbitAccessToken');
  // await FitbitConnector.isTokenValid()
  if (await FitbitConnector.storage.read(key: 'fitbitAccessToken') != null) {
    print('Token ok!');
    return;
  } else if (await FitbitConnector.storage.read(key: 'fitbitRefreshToken') !=
      null) {
    print('Refre Token ok!');
    return;
  } else {
    print('Go to authorization');
    await FitbitConnector.authorize(
        context: context,
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        redirectUri: 'thebestapp://fitbit/auth',
        callbackUrlScheme: 'thebestapp');

    return;
  }
}
