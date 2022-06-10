import 'package:intl/intl.dart';

String dateFormatter(DateTime date, {int opt = 1}) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat formatter_bis = DateFormat('EEEE, d MMMM y');
  String formatted = formatter.format(date);
  String formatted_bis = formatter_bis.format(date);
  // if (opt == 2) {
  //   String formatted = formatter_bis.format(date);
  // }
  return opt == 1 ? formatted : formatted_bis;
}
