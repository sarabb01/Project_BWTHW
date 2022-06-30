// Flutter packages
import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/cupertino.dart';
// Utils
import 'package:the_best_app/Utils/stringsKeywords.dart';

/*
Function Description:
This function checks if the token/refresh token is valid, otherwise asks the user 
to authorize fitbit.
*/

Future<void> checkAuthorization(BuildContext context) async {
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
