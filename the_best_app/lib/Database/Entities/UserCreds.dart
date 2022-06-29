import 'package:floor/floor.dart';

//      TABLE STRUCTURE
// Table Name :
//            Users Credentials
// Attributes :
//           id(int,Primary Key)
//           username(String);
//           password(String);
@entity
class UsersCredentials {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String username;
  final String password;
  UsersCredentials(this.id, this.username, this.password);
}
