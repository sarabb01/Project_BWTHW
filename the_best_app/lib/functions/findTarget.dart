import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_best_app/Repository/database_repository.dart';

Future<String> findTarget(BuildContext context, String user) async {
  // final sp = await SharedPreferences.getInstance();
  // final String user = sp.getString('username')!;
  final logged_user =
      await Provider.of<UsersDatabaseRepo>(context, listen: false)
          .findUser(user);
  print('User $logged_user');
  //print(logged_user!.id);
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
