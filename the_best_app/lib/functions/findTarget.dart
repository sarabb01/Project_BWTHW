// Flutter Packages
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
// Database
import 'package:the_best_app/Repository/database_repository.dart';

/*
Function Description:
This function returns the target selected by the user during the registration phase
*/

Future<String> findTarget(BuildContext context, String user) async {
  final logged_user =
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .findUser(user);
  print('User $logged_user');
  if (logged_user != null) {
    final logged_user_info =
        await Provider.of<UsersDatabaseRepo>(context, listen: false)
            .checkUserInfos(logged_user.id!);
    final level = logged_user_info!.usertarget;

    return level;
  } else {
    return 'None';
  }
}
