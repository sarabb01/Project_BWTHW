import 'package:floor/floor.dart';

// TABLE STRUCTURE
//     Table Name : Users Credentials
// ID(int) USERNAME(String) PASSWORD(String)
@Entity(tableName: 'Users Credentials', primaryKeys: ['id', 'username'])
class Users_Credentials {
  @PrimaryKey(autoGenerate: true)
  final int id;
  final String username;
  final String password;
  Users_Credentials(this.id, this.username, this.password);
}
