import 'package:floor/floor.dart';
import 'UserCreds.dart';

// TABLE STRUCTURE
// Table Name : UserInfos
// Columns : ID(int)
//           ID_from_User_Cred(int)
//           discount_code(String)
@Entity(foreignKeys: [
  ForeignKey(
    childColumns: ['userid'],
    parentColumns: ['id'],
    entity: UsersCredentials,
    onDelete: ForeignKeyAction.cascade,
  )
])
class VoucherList {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  @ColumnInfo(name: 'userid') //From Credentials Table
  final int userId;
  final String disconut_code;
  VoucherList(this.id, this.userId, this.disconut_code);
}
