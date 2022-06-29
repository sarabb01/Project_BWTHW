// Flutter Packages
import 'package:floor/floor.dart';
// Screens
import 'package:the_best_app/Database/Entities/VouchersList.dart';

@dao
abstract class VoucherDao {
  @Query('SELECT * FROM VoucherList WHERE userId = :userid')
  Future<List<VoucherList>?> findAllUserVouchers(int userid);

  @insert
  Future<void> addUserVoucher(VoucherList voucher);

  @Update(
      onConflict: OnConflictStrategy
          .replace) // In ordert to avoid duplicates within the users
  Future<void> updateUserVoucher(VoucherList voucher);

  @delete
  Future<void> deleteUserVoucher(VoucherList voucher);

  @delete
  Future<void> deleteAllUsersVoucher(List<VoucherList> voucherlist);
}
