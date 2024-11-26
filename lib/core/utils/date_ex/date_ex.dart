import 'package:intl/intl.dart';

extension DateEx on DateTime {
  String get toFormattedDate => '$day / $month / $year';

  // String get  toFormattedDate{
  //   DateFormat formatter = DateFormat.yMMMMd('en_US') ; // pattern
  //   return formatter.format(this);
  String get getDayName {
    DateFormat formatter = DateFormat('E');
    return formatter.format(this);
  }
//
// String get dayName {
//   List<String> days = [
//     'MON',
//     'TUE',
//     'WED',
//     'THUE',
//     'FRI',
//     'SAT',
//     'SUN',
//   ];
//   return days[weekday - 1];
// }
}
