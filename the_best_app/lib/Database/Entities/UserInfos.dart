import 'package:floor/floor.dart';
import 'UserCreds.dart';

// TABLE STRUCTURE
// Table Name : UserInfos
// Columns : ID(int)
//           ID_from_User_Cred(int)
//           USERNAME(String)
//           Name(String)
//           Surname(String)
//           Gender(String)
//           Date of Birth (DateTime)
//           User Target (String)
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
