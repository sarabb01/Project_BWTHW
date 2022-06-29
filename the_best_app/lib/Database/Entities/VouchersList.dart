import 'package:floor/floor.dart';
import 'UserCreds.dart';

//      TABLE STRUCTURE
// Table Name :
//            VoucherList
// Attributes :
//           id(int,Primary Key)
//           userId(int,Foreign Key);
//           discount_code(String);
//           discount(String);
//           shop_name(String);
//           QRcode_path(String);
//           discount_code(String);
//           front_image_path(String);

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
  final String discount;
  final String shop_name;
  final String QRcode_path;
  final String discount_code;
  final String front_image_path;
  VoucherList(this.id, this.userId, this.discount, this.shop_name,
      this.QRcode_path, this.discount_code, this.front_image_path);
}
