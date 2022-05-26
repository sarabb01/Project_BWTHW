import 'package:floor/floor.dart';

// TABLE STRUCTURE
//     Table Name : Users Credentials
// ID(int) USERNAME(String) PASSWORD(String)
@entity
class UsersCredentials {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String password;
  UsersCredentials(this.id, this.username, this.password);
}
