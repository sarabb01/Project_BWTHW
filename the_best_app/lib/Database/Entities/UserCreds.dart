import 'package:floor/floor.dart';

// TABLE STRUCTURE
// Table Name : Users Credentials
// Column Names: ID(int) USERNAME(String) PASSWORD(String)
@Entity(tableName: "User_Creddentials")
class UsersCredentials {
  @PrimaryKey(autoGenerate: true)
  final int? id; // Since the id is automatically generated

  final String username;

  final String password;
  UsersCredentials(this.id, this.username, this.password);
}
