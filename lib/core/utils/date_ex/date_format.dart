import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  DateFormat formatter = DateFormat.yMMMMd('en_US');
  return formatter.format(date);
}
// month day year
