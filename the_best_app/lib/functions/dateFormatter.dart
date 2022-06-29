//Flutter packages
import 'package:intl/intl.dart';

/*
Function Description:
This function takes a object type 'DateTime' and returns a String
*/

String dateFormatter(DateTime date, {int opt = 1}) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter_bis = DateFormat('EEEE, d MMMM y');
  String formatted = formatter.format(date);
  String formatted_bis = formatter_bis.format(date);
//If opt 2 is selected, formatted_bis is resutned
  return opt == 1 ? formatted : formatted_bis;
}
