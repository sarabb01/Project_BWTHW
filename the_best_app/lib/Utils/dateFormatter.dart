import 'package:intl/intl.dart';

String dateFormatter(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formatted = formatter.format(date);
  return formatted;
}
