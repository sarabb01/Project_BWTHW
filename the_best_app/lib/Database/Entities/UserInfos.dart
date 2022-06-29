import 'package:floor/floor.dart';
import 'UserCreds.dart';

//      TABLE STRUCTURE
// Table Name :
//          UserInfos
// Attributes :
//           id(int,Primary Key)
//           userId(int,Foreign Key)
//           name(String)
//           surname(String)
//           gender(String)
//           dateofbirth(DateTime)
//           usertarget(String)
@Entity(foreignKeys: [
  ForeignKey(
    childColumns: ['userid'],
    parentColumns: ['id'],
    entity: UsersCredentials,
    onDelete: ForeignKeyAction.cascade,
  )
])
class UserInfos {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'userid') //From Credentials Table
  final int userId;
  final String name;
  final String surname;
  final String gender;
  final DateTime dateofbirth;
  final String usertarget;
  UserInfos(this.id, this.userId, this.name, this.surname, this.gender,
      this.dateofbirth, this.usertarget);
}
